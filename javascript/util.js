.pragma library
Qt.include("fontawesome.js")
Qt.include("../colorstyles/porpoise.js")

var Theme = Style
var FA = Icon
var sizeKibiNameDecimal = ["B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

function humanReadableSize(size) {
    var index = 0
    var tempSize = size
    while(tempSize >= 1024) {
        tempSize /= 1024
        index++
    }
    return tempSize.toFixed(2) + " " + sizeKibiNameDecimal[index]
}
