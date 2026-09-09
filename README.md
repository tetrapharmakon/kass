# KASS

A small Jekyll page for the joint Tallinn-Tartu category theory seminar.
Meeting data lives in `_data/meetings.yml`. The template is `index.html` and the
presentation is `styles.css`. There are no parent layouts, JavaScript, or custom
plugins.

## Use in Another Project

Place `index.html`, `styles.css`, and `assets/` anywhere in another Jekyll
project's source directory, and merge `_data/meetings.yml` into that project's
top-level `_data/` directory: Jekyll reads data files only from the site root, so
this one file cannot travel inside the folder. The folder itself can be renamed.
Its HTML document does not inherit the host's layout, and local asset links are
folder-relative.

If the host site already has a `_data/meetings.yml`, rename this one and update the
`site.data.meetings` reference in `index.html` to match.

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

Add entries to `_data/meetings.yml`, one list item per talk. The title, speaker,
and date are required; all other fields are optional:

```yaml
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

Meetings are sorted automatically by date and then by time, earliest first, whatever
order they are written in. An entry with no `time` sorts to the start of its day. Keep
past entries as the seminar record; no separate archive or status field is required.
If several talks share a meeting, add one entry per talk with the same date and venue.
Omit optional fields until their details are available. When `_data/meetings.yml` is
empty, the page shows the announcement placeholder automatically.

Put slides in this folder's `assets/` directory and use a relative path such as
`assets/filename.pdf`, or supply a full external URL. Avoid paths starting with
`/` so the folder remains portable. Edit the introduction or contact
information directly in `index.html`; routine meeting updates touch only the data
file.
