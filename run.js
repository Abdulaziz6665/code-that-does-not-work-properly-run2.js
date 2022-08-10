const data = require('./data.js');

const morning = '08:00-09:00';
const afternoon = '12:00-13:00';
const evening = '18:00-19:00';

function addDays(date, number) {
    const newDate = new Date(date);
    return new Date(newDate.setDate(newDate.getDate() + number));
}

const sortedData = {}

const bigDay = data.sort((a, b) => a.medicine_day - b.medicine_day).at(-1)
const bigLowDate = ''

for(let i = 0; i < bigDay.medicine_day; i++) {
    const date = addDays(bigDay.created_at, i).toISOString().split('T')[0]
    sortedData[date] = (data.map(item => {
        const itemDate = addDays(item.created_at, +item.medicine_day).toISOString().split('T')[0]
        // console.log(itemDate, date)
        if(itemDate >= item.created_at && null) {
            return {
                8: item.times.includes(morning) ? {[item.medicine_name]: item.time_to_take} : [],
                13: item.times.includes(afternoon) ? {[item.medicine_name]: item.time_to_take} : [],
                19: item.times.includes(evening) ? {[item.medicine_name]: item.time_to_take} : []
            }
        }
    }))[0]
    // const itemDate = addDays2(itemCreatedAt, itemMedicineDay).toISOString().split('T')[0]
    // console.log(itemDate, 'date')
}

// for (let i = 0; i < bigDate.medicine_day; i++) {
    
// }

// for (const i of Object.keys(sortedData)) {
//     console.log(i['8'])
// }

// console.log(sortedData)

// console.log(addDays('2022-07-23', 15))
// console.log(Array(3).fill().map(i => ({test: 2})))

const a = {
    '2022-07-23': {
      '8': [{'text': 10}, {'text': 5}, {'text': 8}],
      '13': [{'text': 5}, {'text': 8}],
      '19': [{'text': 10}, {'text': 5}, {'text': 8}]
    }
}