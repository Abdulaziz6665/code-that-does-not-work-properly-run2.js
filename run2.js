const data = require('./data.js');

const morning = '08:00-09:00';
const afternoon = '12:00-13:00';
const evening = '18:00-19:00';

function addDays(date, number) {
    const newDate = new Date(date);
    return new Date(newDate.setDate(newDate.getDate() + number));
}

const result = {};

for (let i = 0; i < data.length; i++) {

    const med = data[i].medicine_name
    const time = data[i].time_to_take

    const obj = {
        _8: data[i].times.includes(morning) ? [{ [med]: +time }] : [],
        _13: data[i].times.includes(afternoon) ? [{ [med]: +time }] : [],
        _19: data[i].times.includes(evening) ? [{ [med]: +time }] : []
    }

    for (let j = 0; j < data[i].medicine_day; j++) {
        let dateww = addDays(data[i].created_at, j).toISOString().split('T')[0]
        dateww = 'test_' + dateww.split('-')[2]
        if (result[dateww]) {
            
            if (data[i].times.includes(morning)) {
                result[dateww]._8.push({ [med]: +time })
            }
            if (data[i].times.includes(afternoon)) {
                result[dateww]._13.push({ [med]: +time })
            }
            if (data[i].times.includes(evening)) {
                result[dateww]._19.push({ [med]: +time })
            }

        } else {
            result[dateww] = obj;
        }
    }
}

for (let i of Object.keys(result)) {
    console.log(i, result[i])
}