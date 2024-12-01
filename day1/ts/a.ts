let sum: number = 0;

const input = await Deno.readTextFile("input.txt");

// console.log(input);

// define a left list and a right list
let left_list: number[] = [];
let right_list: number[] = [];

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

// after all inputs are in, sort the two lists by least to greatest
left_list.sort((a, b) => a - b);
right_list.sort((a, b) => a - b);

// for the list size, find the difference of the index by math.abs and then add that to the sum
for (let i = 0; i < left_list.length; i++) {
    sum += Math.abs(left_list[i] - right_list[i]);
    console.log(
        `Left value: ${left_list[i]}, right value: ${right_list[i]}\nEqual to:`,
        sum,
    );
}

console.log(sum);
