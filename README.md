# KASS

A self-contained Jekyll page for the joint Tallinn-Tartu category theory seminar.
Meeting data lives in the YAML header of `index.html`, above the Liquid template.
Presentation lives in `styles.css`. Everything needed is inside this folder:
no parent layouts, data files, JavaScript, or custom plugins.

## Use in Another Project

Place the entire folder anywhere in another Jekyll project's source directory,
then build that project normally. The folder can be renamed. Its HTML document
does not inherit the host's layout, and local asset links are folder-relative.

The page uses the host's `url` and `baseurl` for canonical and social-preview URLs.
If no `url` is configured, those optional metadata links are omitted.

To run it as its own site from inside this folder, using the bundled Nix
flake (no Jekyll install needed):

```sh
nix run         # serve at http://localhost:4000/
nix run .#build # render the site into _site/
```

With Jekyll installed, `jekyll serve` and `jekyll build` work equally well; no
configuration file is required to run. For a production build, publish the
contents of `_site/`.

For a non-Jekyll project or a plain static host, copy that generated output rather
than these source files. Liquid must be processed by Jekyll; opening the source
HTML directly in a browser is not a supported preview.

Committing and pushing this folder to your repository and enabling GitHub Pages
publishes it through Jekyll, which renders the template with the full
presentation from `styles.css`.

## Add a Meeting

Replace `meetings: []` in the YAML header at the top of `index.html` with entries
like these. Leave `layout: null` and the enclosing `---` lines in place. The title,
speaker, and date are required; all other fields are optional:

```yaml
meetings:
  - title: "Talk title"
    speaker: "Speaker name"
    affiliation: "University or institute"
    date: "2026-10-15"
    time: "14:00"
    venue: "Venue, room, city"
    abstract: |
      Abstract or a short description. **Markdown** is supported here.
    slides: "assets/filename.pdf"
```

The example date is illustrative; replace it with the confirmed date. Keep dates
quoted in `YYYY-MM-DD` format and times quoted in `HH:MM` format, using Estonian
local time.

Meetings are sorted automatically by date, latest first. Keep past entries as the
seminar record; no separate archive or status field is required. If several talks
share a meeting, add one entry per talk with the same date and venue. Omit optional
fields until their details are available. When the list is empty (`meetings: []`), the page
shows the announcement placeholder automatically.

Put slides in this folder's `assets/` directory and use a relative path such as
`assets/filename.pdf`, or supply a full external URL. Avoid paths starting with
`/` so the folder remains portable. Edit the introduction or contact
information below the YAML header; routine meeting updates need no HTML changes.
