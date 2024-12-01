let total: number = 0;

const input = await Deno.readTextFile("input.txt");

// define a left list and a right list
let left_list: number[] = [];
let right_list: number[] = [];

// define a map to count the occurences of each number
const occurrence_map = new Map<number, number>();

// split input by \n

const lines = input.split("\n");

// console.log(lines);

//  "65897   82748", "44296   15919", "21934   96178", "77571   39195",

// for every line
// split input by 3 spaces
for (const line of lines) {
    const trim = line.trim();
    const lists_content = trim.split("   ");

    // put first index in left list, second index in right list
    if (lists_content.length === 2) {
        const leftValue = Number(lists_content[0]);
        const rightValue = Number(lists_content[1]);

        // without the isNaN checks, i would get an undefined somewhere ?
        if (!isNaN(leftValue) && !isNaN(rightValue)) {
            left_list.push(Number(lists_content[0]));
            right_list.push(Number(lists_content[1]));
        }
    }
}

// init the map for all values in the left list
for (let i = 0; i < left_list.length; i++) {
    occurrence_map.set(left_list[i], 0);
}

// edit the map using the right side of the list to count for the occurences of the index
for (let i = 0; i < right_list.length; i++) {
    // get the index from the map if there is one
    let val = occurrence_map.get(right_list[i])

    if (val === undefined) continue;

    // if there is an occurence of the index, add 1 to the key's value
    occurrence_map.set(right_list[i], val += 1)
}

// for the list size, multiply the number by the occurences of it in the right list then add to the sum

//for (let i = 0; i < occurrence_map.size; i++) {
//    const multiple = occurrence_map.get(i);
//    if (!multiple) continue;
//    total += i * multiple;
//}

for (const [key, value] of occurrence_map.entries()) {
    total += key * value;
}

console.log(total)
