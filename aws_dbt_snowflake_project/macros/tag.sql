{% macro tag(column_name) %}
    CASE
        WHEN {{ column_name }} < 100 THEN 'Low'
        WHEN {{ column_name }} >= 100 AND {{ column_name }} < 200 THEN 'Medium'
        ELSE 'High'
    END
{% endmacro %}