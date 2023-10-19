{% macro format_month(order_date) %}
  TO_CHAR({{ order_date }}, 'TMMonth')
{% endmacro %}
