{%- extends 'base.tpl' -%}
{% import "debug.html" as dbg %}

{% block notebook_css %}
  {{ super() }}
  <style>
    /*Hide empty cells*/
    .jp-mod-noOutputs.jp-mod-noInput {
      display: none;
    }
  </style>
{% endblock notebook_css %}

{% block data_priority scoped %}
{{ dbg.debug_all() }}
{% if output %}
  <script type="application/vnd.voila.cell-output+json">
    {{ output | tojson }}
  </script>
{% endif %}
{% endblock data_priority %}

{%- block codecell -%}
  <div cell-index="{{cellloop.index}}">
    {{ super() }}
  </div>
{%- endblock codecell -%}

{%- block markdowncell -%}
  <div cell-index="{{cellloop.index}}">
    {{ super() }}
  </div>
{%- endblock markdowncell -%}

{%- block rawcell -%}
  <div cell-index="{{cellloop.index}}">
    {{ super() }}
  </div>
{%- endblock rawcell -%}