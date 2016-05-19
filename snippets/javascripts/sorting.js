/**
 * Sorting elements of array / objects
 *
 * This snippets sort array / object items,
 * the first approach is to sort it via numeric
 * while on second try to sort it alphabetically via specified string
 */

var diff = 0;

arrayName.sort(function(a, b) {
    diff = parseInt(a.value) - parseInt(b.value);
    if (diff === 0) {
        // use the inverse approach since we use reverse()
        if (a.string.toLowerCase() > b.string.toLowerCase()) {
            diffs = -1;
        } else if (a.string.toLowerCase() < b.string.toLowerCase()) {
            diffs = 1;
        } else {
            diffs = 0;
        }
    }
    return diff;
});

arrayName.reverse();