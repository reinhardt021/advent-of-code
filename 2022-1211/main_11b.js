const fs = require('fs')
const readline = require('readline')

const MONKEY = 'Monkey'
const STARTING = 'Starting'
const OPERATION = 'Operation:'
const PLUS = '+'
const MULTIPLY = '*'
const OLD = 'old'

const TEST = 'Test:'
const DIVISIBLE = 'divisible'

const IF = 'If'
const T = 'true:'
const F = 'false:'

function parse_monkeys(lines) {
    const monkeys = {};
    let curr_monkey = undefined;

    index = 0
    while (index < lines.length) {
        const line = lines[index]
        index += 1

        const parts = line.split(' ').filter(x => x != '');
        //console.log(`parts: ${parts.map(x => `[${x}]`)}`);
        const line_type = parts[0]
        if (line_type == MONKEY) {
            curr_monkey = parts[1].match(/\d+/)[0]
            monkeys[curr_monkey] = {
                items: [],
                operand: '',
                factor: '',
                test: '',
                quotient: '',
                success_monkey: '',
                fail_monkey: '',
                inspect_count: 0,
            }
        }
        
        if (curr_monkey == undefined) {
            continue; // to end loop
        }

        console.log(`line_type: ${line_type}`);
        if (line_type == STARTING) {
            const items = line.match(/\d+/);
            monkeys[curr_monkey]['items'] = items.map(x => parseInt(x))
        }

        if (line_type == OPERATION) {
            const index_operand = 4
            const index_factor = 5
            const operand = parts[index_operand]
            const factor = parts[index_factor]
            monkeys[curr_monkey]['operand'] = operand
            monkeys[curr_monkey]['factor'] = factor
        }

        if (line_type == TEST) {
            const index_test = 1
            const index_quotient = 3
            const test = parts[index_test]
            const quotient = parts[index_quotient]
            monkeys[curr_monkey]['test'] = test
            monkeys[curr_monkey]['quotient'] = quotient
        }

        if (line_type == IF) {
            const monkey = line.match(/\d+/).shift()
            const success_or_fail = parts[1] == T ? 'success_monkey' : 'fail_monkey' 
            monkeys[curr_monkey][success_or_fail] = monkey
        }
    } 

    console.log('monkeys: ' + JSON.stringify(monkeys));
    return monkeys;
}

function parse_file(filename) {
    const file = fs.readFileSync(filename, 'UTF-8')
    const lines = file.split("\n")
    const monkeys = parse_monkeys(lines)

    return monkeys;
}

function display_monkeys(monkeys) {
    const mkeys = Object.keys(monkeys)
    let index = 0
    while (index < mkeys.length) {
        const key = mkeys[index]
        index += 1
        const curr_monkey = monkeys[key]
        const count = curr_monkey['inspect_count']
        console.log(`Monkey ${key}: inspected items ${count} times`);
    }

}

function get_new_level(worry, operand, factor) {
    let new_worry = 0
    if (factor == OLD) {
        factor = worry
    }

    if (operand == PLUS) {
        new_worry = worry + factor
        return new_worry
    } 
    if (operand == MULTIPLY) {
        new_worry = worry * factor
        return new_worry
    }

    return new_worry
}

function assess_worry(worry, test, quotient) {

    return (worry % quotient) == 0
}

function run_round(monkeys) {
    let index = 0
    const mkeys = Object.keys(monkeys)
    while (index < mkeys.length) {
        const key = mkeys[index]
        index += 1

        const curr_monkey = monkeys[key]
        const items = curr_monkey['items']
        let i = 0
        while (i < items.length) {
            const item = items[i]
            i += 1

            const count = curr_monkey['inspect_count']
            curr_monkey['inspect_count'] = 1 + count

            const operand = curr_monkey['operand']
            const factor = curr_monkey['factor']
            const inspect_worry = get_new_level(item, operand, factor)

            const test = curr_monkey['test']
            const quotient = curr_monkey['quotient']
            const worried = assess_worry(inspect_worry, test, quotient)
            const which_monkey = worried ? 'success_monkey' : 'fail_monkey'
            const monkey_key = curr_monkey[which_monkey]

            const next_monkey = monkeys[monkey_key]
            next_monkey['items'].concat(inspect_worry)
            monkeys[monkey_key] = next_monkey
        }

        curr_monkey['items'] = []
        monkeys[key] = curr_monkey
    } 

    return monkeys
}

function calculate_monkey_business(monkeys) {
    let monkey_business = 0

    const counts = Object.keys(monkeys).map(key => {
        return monkeys[key]['inspect_count']
    });

    const decreasing = counts.sort().reverse()
    const first = decreasing[0]
    const second = decreasing[1]
    console.log(`1st[${first}] 2nd[${second}]`);

    monkey_business = first * second

    return monkey_business
}

function run_code(monkeys) {
    //const rounds = 10000
    //const rounds = 20
    const rounds = 2
    let round = 1

    const range = [...Array(10).keys()]
    const test = [1, 20].concat(range.map(x => (x+1)*1000))

    while (round <= rounds) {
        //monkeys = run_round(monkeys)
        if (test.includes(round)) {
            console.log("\nROUND: " + round);
            display_monkeys(monkeys)
        } else {
            console.log("ROUND: " + round);
        }
        
        round += 1
    } 

    return calculate_monkey_business(monkeys)
}

function assertEquals(expected, actual) {
    const output = (expected == actual) ? 
        `PASS: exp[${expected}] == act[${actual}]` :
        `FAIL: exp[${expected}] != act[${actual}]`;
    console.log(output);
}


const aoc_day = 11
const files = {
  //file => expected result
    a: 10605, 
  //b: undefined, // no expected result yet
  //c: undefined, //13140,
}

const fileKeys = Object.keys(files)
let index = 0
while (index < fileKeys.length) {
    const file = fileKeys[index]
    index += 1

    const exp = files[file]

    const filename = `input_${aoc_day}${file}.txt`
    const data = parse_file(filename)
    const results = run_code(data)
    console.log("results: " + results)
    if (exp) {
        assertEquals(exp, results)
    }
}
