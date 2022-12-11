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

let monkeys = []
function parse_file(filename) {
    const file  = readline.createInterface({
        input: fs.createReadStream(filename),
        output: process.stdout,
        terminal: false
    });

    file.on('line', line => {
        console.log('l: '+ line);
    });

  //file = File.open(filename)
  //data = file.read.split("\n")
  //monkeys = parse_monkeys(data)
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
