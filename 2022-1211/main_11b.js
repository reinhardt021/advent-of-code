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
        //parts = parts
        //const parts = line.match(/\S+/)
        console.log(`parts: ${parts.map(x => `[${x}]`)}`);
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
    //const results = run_code(data)
    //console.log("results: " + results)
    //if (exp) {
        //assertEquals(expected_result, results)
    //}
}
