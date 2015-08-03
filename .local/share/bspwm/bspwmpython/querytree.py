from subprocess import check_output

INDENT_CHAR = '\t'
SPLIT_VERTICAL = 1
SPLIT_HORIZONTAL = 2


def get_raw_tree (windows=None, desktops=None, monitors=None):
    sel_args = (
        ([] if windows is None else ['-w', windows]) +
        ([] if desktops is None else ['-d', desktops]) +
        ([] if monitors is None else ['-m', monitors])
    )
    return check_output(['bspc', 'query', '-T'] + sel_args).decode()


def get_indentation (line):
    i = 0
    for i, c in enumerate(line):
        if c != INDENT_CHAR:
            return i


def tree_from_indentation (lines):
    if not lines:
        return []

    base_indentation = get_indentation(lines[0])
    remaining_lines = list(lines)
    lines = []
    current_line = None
    children = None

    def cleanup ():
        if current_line is not None:
            lines.append((current_line, tree_from_indentation(children)))

    while remaining_lines:
        line = remaining_lines.pop(0).rstrip()
        indentation = get_indentation(line)
        if not line[indentation:]:
            # ignore blank lines
            continue

        if indentation < base_indentation:
            raise ValueError('invalid base_indentation: found a less indented '
                             'line')
        elif indentation == base_indentation:
            cleanup()
            current_line = line[indentation:]
            children = []
        else:
            if current_line is None:
                raise ValueError(
                    'invalid base_indentation: first line is more indented '
                    '({} > {})'.format(indentation, base_indentation)
                )
            else:
                children.append(line)

    cleanup()
    return lines


def monitor_name (line):
    return line.split()[0]


def desktop_name (line):
    return line.split()[0]


def parse_windows (tree):
    results = []
    for line, sub_tree in tree:
        words = line.split()
        if words[0] in ('V', 'H'):
            results.append({
                'type': SPLIT_VERTICAL if words[0] == 'V' else SPLIT_HORIZONTAL,
                'ratio': float(words[2]),
                'children': parse_windows(sub_tree)
            })
        else:
            results.append({'type': 'window', 'id': words[3]})
    return results


# gives { monitor: { desktop: windows } }
# windows = [ split ] | [ window, window ]
# split = {
#   'type': SPLIT_VERTICAL | SPLIT_HORIZONTAL,
#   'ratio': float,
#   'children': windows
# }
# window = { 'type': 'window', 'id': window_id }
def parse_tree (raw_tree):
    tree = {}
    for m_line, new_ds in tree_from_indentation(raw_tree.splitlines()):
        ds = tree.setdefault(monitor_name(m_line), {})
        for d_line, ws in new_ds:
            ds.setdefault(desktop_name(d_line), []).extend(parse_windows(ws))
    return tree


def path_to_window (tree, w_id):
    if isinstance(tree, dict):
        items = [((k, v), v) for k, v in tree.items()]
    else:
        items = []
        for i, item in enumerate(tree):
            result = (i, item)
            if item['type'] == 'window':
                if item['id'] == w_id:
                    return [result]
            else:
                items.append((result, item['children']))

    for result, children in items:
        parents = path_to_window(children, w_id)
        if parents is not None:
            return [result] + parents
