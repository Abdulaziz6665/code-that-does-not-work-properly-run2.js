create or replace function test() returns json as $$
DECLARE
    morning varchar;
    afternoon varchar;
    evening varchar;
    result json;
    time_8 json;
    time_13 json;
    time_19 json;
    field record;
    day date;

BEGIN

    morning := '08:00-09:00';
    afternoon := '12:00-13:00';
    evening := '18:00-19:00';
    result := '{}';
    -- result := result::jsonb || '{"day": {"8": [ {"dori" : 2 } ] } }'::jsonb;
    -- raise info 'result: %', result;
    for field in SELECT
                    dt.*,
                    d.created_at
                FROM diagnos as d
                JOIN diagnos_times as dt ON d.id = dt.diagnos_id
                JOIN sub_services as ss ON ss.id = d.sub_services_id
                WHERE (d.created_at + (dt.medicine_day||' day')::interval)::date >= now()::date
                    AND ss.service_id = '2a3a220c-106c-4355-83c5-1f3b54a17a82'
                    AND d.patient_id = '789a4fdf-6d2f-455a-b407-18d8f0565a25'
                ORDER BY d.created_at asc limit 2 offset 7 LOOP

        time_8 := case when morning = any(field.times)
        then (select ('{' || '"'|| field.medicine_name || '"' || ':' || '"' || field.time_to_take||'"' ||'}')::json) else '{}'::json end;
        time_13 := case when afternoon = any(field.times)
        then (select ('{' || '"'|| field.medicine_name || '"' || ':' || '"' || field.time_to_take||'"' ||'}')::json) else '{}'::json end;
        time_19 := case when evening = any(field.times)
        then (select ('{' || '"'|| field.medicine_name || '"' || ':' || '"' || field.time_to_take||'"' ||'}')::json) else '{}'::json end;

        -- raise info 'time_8: %', time_8;
        -- raise info 'time_13: %', time_13;
        -- raise info 'time_19: %', time_19;

        for cnt in 1..field.medicine_day LOOP
            day := (select (field.created_at + ((cnt - 1)::varchar ||' day')::interval)::date);

            if (select result ->> day::varchar) is not null then

                if (time_8::jsonb ->> field.medicine_name::varchar) is not null then
                    result := jsonb_set(result::jsonb, (result->day::varchar->'8')::jsonb, time_8::jsonb);
                    -- result := result::jsonb || (result->day::varchar->>'8')::jsonb || time_8::jsonb;
                end if;
                
            else
                result := result::jsonb || ('{"'||day||'": {"8": ['||time_8||'], "13": ['||time_13||'], "19": ['||time_19||']}}')::jsonb;
            end if;

            -- raise info 'day: %', day;
        END LOOP;

    END LOOP;

    RETURN result;
END;
$$ language plpgsql;

select (now() + ('1 day')::interval)::date
select (array['{"sender":"pablo","body":"they are on to us"}', 
         '{"sender":"arthur"}']::json[])


select ('{"day"' || ':' || '{' || '"8":'||'"time_8"', '"13":'||'"time_13"', '"19":'||'"time_19"' || '}' || '}')::json;

(select ('{'|| '"'|| day ||'"' || ':' {"8":time_8,"13":time_13, "19":time_19 } || '}')::jsonb)





select ('{"main": {"sub_main": [ {"text" : 15 },     ] } }')::json;