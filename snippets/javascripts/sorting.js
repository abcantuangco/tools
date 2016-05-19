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
        diff = a.string < b.string; // use the less than approach since we use reverse()
    }
    return diff;
});

arrayName.reverse();