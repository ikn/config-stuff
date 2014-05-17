var srctonode = [];
var okswf = [];
 
var swfid = 0;
 
function putitback(event)
{
    okswf.push(event.target.getAttribute("swfsrc"));
    var swf = srctonode[event.target.getAttribute("swfsrc")].cloneNode(true);
    event.target.parentNode.insertBefore(swf, event.target);
    event.target.parentNode.removeChild(event.target);
}
 
function flashblock(event)
{
    if (event.target.tagName == "EMBED" || event.target.tagName == "OBJECT") {
        var src = event.target.getAttribute("flblid");
        if (!src) {
            src = "id" + swfid++;
            event.target.setAttribute("flblid", src);
        }
 
        var ret = false;
        for(var i = 0; i < okswf.length; i++) {
            if (okswf[i] == src) {
                ret = true;
                break;
            }
        }
        if (ret)
            return;
 
        event.preventDefault();
        var w = event.target.getAttribute("width");
        var h = event.target.getAttribute("height");
 
        var ph = document.createElement('div');
        ph.setAttribute("swfsrc", src);
        ph.setAttribute("style", "background: #FFFFFF;" +
                                 "font-size: 16px;" +
                                 "border: 2px red dotted;" +
                                 "width: " + w + "; height: " + h + ";" +
                                 "color: #000000;" +
                                 "padding: "+(h/2-16/2)+"px;");
        ph.innerHTML = "flashblocked!";
        ph.addEventListener("mousedown", putitback, false);
 
        event.target.parentNode.insertBefore(ph, event.target);
        event.target.parentNode.removeChild(event.target);
 
        srctonode[src] = event.target;
    }
}
 
document.addEventListener("beforeload", flashblock, true);
