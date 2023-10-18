SELECT
    passengerId::bigint as passenger_id,
    CASE sex WHEN 1 THEN 'male' WHEN 0 THEN 'female' ELSE NULL END::VARCHAR as sex,
    age::integer,
    fare::double precision,
    CASE embarked
        WHEN 0 THEN 'Cherbourg'
        WHEN 1 THEN 'Queenstown'
        WHEN 2 THEN 'Southampton'
        ELSE NULL
    END::VARCHAR as embarked_at,
    pclass::integer as passenger_class,
    parch::integer  as parents_children,
    sibsp::integer  as siblings_spouses,
    CASE "2urvived" WHEN 1 THEN TRUE WHEN 0 THEN FALSE ELSE NULL END as survived
FROM
    titanic
	