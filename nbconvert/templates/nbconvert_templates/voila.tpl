{%- extends 'base.tpl' -%}

{# this overrides the default behaviour of directly starting the kernel and executing the notebook #}
{% block notebook_execute %}
{% endblock notebook_execute %}

{% block body_content %}
{# from this point on, the kernel is started #}
{%- with kernel_id = kernel_start() -%}
  <script id="jupyter-config-data" type="application/json">
  {
      "baseUrl": "{{resources.base_url}}",
      "kernelId": "{{kernel_id}}"
  }
  </script>
  {% set cell_count = nb.cells|length %}

  {%- for cell in cell_generator(nb, kernel_id) -%}
    {% set cellloop = loop %}
    {%- block any_cell scoped -%}
      <div class="jp-Cell">
        <script>
          voila_process({{ cellloop.index }}, {{ cell_count }})
        </script>
        {{ super() }}
      </div>
    {%- endblock any_cell -%}
  {%- endfor -%}
{% endwith %}
{% endblock body_content %}

{% block input_group -%}
<div class="jp-Cell-inputWrapper">
    <div class="jp-InputArea jp-Cell-inputArea">
        {{ super() }}
    </div>
</div>
{% endblock input_group %}

{% block output_group -%}
<div class="jp-Cell-outputWrapper">
    {{ super() }}
</div>
{% endblock output_group %}

{% block in_prompt -%}
<div class="jp-InputPrompt jp-InputArea-prompt">
    {%- if cell.execution_count is defined -%}
    [{{ cell.execution_count|replace(None, "&nbsp;") }}]:
    {%- else -%}
    [ ]:
    {%- endif -%}
</div>
{% endblock in_prompt %}

{% block empty_in_prompt -%}
<div class="jp-InputPrompt jp-InputArea-prompt"></div>
{%- endblock empty_in_prompt %}

{% block output_prompt %}
{% if output.output_type == 'execute_result' %}
    <div class="jp-OutputPrompt jp-OutputArea-prompt">
    [{{ cell.execution_count|replace(None, "&nbsp;") }}]:
    </div>
{% endif %}
{% endblock output_prompt %}