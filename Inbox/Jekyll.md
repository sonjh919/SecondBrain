---
---

```
bundle exec jekyll serve
```

http://127.0.0.1:4000/

---

## \_layouts

### default
```html
{% include head.html %}

{% include nav.html %}

{{ content }}

{% include footer.html %}

{% include link-previews.html wrapperQuerySelector="content" %}
```

### note
```
---

layout: default

---

  

<article>

  <div>

    <h1>{{ page.title }}</h1>

    <time datetime="{{ page.last_modified_at | date_to_xmlschema }}">{% if page.type != 'pages' %}

      Last updated on {{ page.last_modified_at | date: "%B %-d, %Y" }}

      {% endif %}

    </time>

  </div>

  

  <div id="notes-entry-container">

    <content>

      {{ content }}

      <p>This line appears after every note.</p>

    </content>

  

    <side style="font-size: 0.9em">

      <h3 style="margin-bottom: 1em">Notes mentioning this note</h3>

      {% if page.backlinks.size > 0 %}

      <div style="display: grid; grid-gap: 1em; grid-template-columns: repeat(1fr);">

      {% for backlink in page.backlinks %}

        <div class="backlink-box">

        <a class="internal-link" href="{{ site.baseurl }}{{ backlink.url }}{%- if site.use_html_extension -%}.html{%- endif -%}">{{ backlink.title }}</a><br>

        <div style="font-size: 0.9em">{{ backlink.excerpt | strip_html | truncatewords: 20 }}</div>

        </div>

      {% endfor %}

      </div>

      {% else %}

  

      <div style="font-size: 0.9em">

        <p>

          There are no notes linking to this note.

        </p>

      </div>

      {% endif %}

    </side>

  </div>

</article>

  

<hr>

  

<p>Here are all the notes in this garden, along with their links, visualized as a graph.</p>

  

{% include notes_graph.html %}
```

### page
```
--- layout: default --- {{ content }}
```


---

link-previews
notes-graph. html, json


---

graph-wrapper

---

### internal-link

\_pages -> index.md **해결**
\_includes -> link-previews.html
\_includes -> nav.html
\_sass -> \_style.scss
\_site -> consistency.html

---

### {{ site.baseurl }}{{ note.url }}