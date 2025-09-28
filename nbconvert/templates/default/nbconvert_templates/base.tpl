{%- extends 'nbconvert/templates/lab/index.html.j2' -%}
{% import "debug.html" as dbg %}

{%- block html_head_js -%}
{%- endblock html_head_js -%}

{%- block notebook_css -%}
  {{ super() }}
{%- endblock notebook_css -%}

{%- block body_header -%}
<body data-base-url="{{resources.base_url}}voila/" data-voila="voila">
  {{ dbg.debug_all() }}
  <div id="rendered_cells" style="display: none">
{%- endblock body_header -%}

{%- block body_loop -%}
  {%- for cell in nb.cells -%}
    {% set cellloop = loop %}
      {%- block any_cell scoped -%}
          {{ super() }}
      {%- endblock any_cell -%}
  {%- endfor -%}
{%- endblock body_loop -%}

{%- block body_footer -%}
  </div>
  <script type="text/javascript">
    window.voila_finish();
  </script>
{%- endblock body_footer -%}

{% block footer_js %}
{% endblock footer_js %}