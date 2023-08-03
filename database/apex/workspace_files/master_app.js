//
// WAIT FOR ELEMENT TO EXIST
//
const wait_for_element = function(search, start, fn, disconnect) {
    var ob  = new MutationObserver(function(mutations) {
        if ($(search).length) {
            fn(search, start);
            if (disconnect) {
                observer.disconnect();  // keep observing
            }
        }
    });
    //
    ob.observe(document.getElementById(start), {
        childList: true,
        subtree: true
    });
};



//
// COPY TO CLIPBOARD
//
const copy_to_clipboard = function (text) {
    var dummy = document.createElement('textarea');
    document.body.appendChild(dummy);
    dummy.value = text;
    dummy.select();
    document.execCommand('copy');
    document.body.removeChild(dummy);
}



//
// COPY GRID CELL - ATTACH ONLY TO GRIDS
//
/*
const attach_copy_to_grid = function (el) {
    console.log('ADDING...', el);
    $(el).one('copy', (event) => {
        console.log('ATTACHED');
        event.clipboardData.setData('text/plain', $(document.activeElement)[0].innerText || window.getSelection());
        event.preventDefault();
    });
};
//
wait_for_element('.a-GV-cell', 'main', attach_copy_to_grid);
*/



//
// CREATE COLORFUL IG/IR CELLS
//
const color_cell = function (options, value, title, color_bg, color_text) {
    if (value && value.length && ((color_bg && color_bg.length) || (color_text && color_text.length))) {
        options.defaultGridColumnOptions = {
            cellTemplate: '<div style="background: ' + color_bg + '; color: ' + color_text + ';" title="' + title + '">' + value + '</div>'
        };
    }
    else {
        options.defaultGridColumnOptions = {
            cellTemplate: '<span title="' + title + '">' + value + '</span>'
        };
    }
    return options;
}

