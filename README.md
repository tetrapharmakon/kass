# KASS

A Jekyll site for the joint Tallinn–Tartu category theory seminar. The front page
shows the meeting with the latest date, including announced future meetings.
Earlier meetings appear as links, newest first. Each meeting has a permanent page.
The plugin `_plugins/meeting_pages.rb` generates pages from meeting YAML files.
For GitHub Pages, build with GitHub Actions and deploy `_site/`; its default
Jekyll build does not run custom plugins.

## Build and preview

```sh
nix run         # serve at http://localhost:4000/
nix run .#build # render into _site/
```

With Jekyll installed, `jekyll serve` and `jekyll build` also work. Publish the
contents of `_site/` to a static host. Source HTML requires Jekyll processing.

## Add a meeting

Create `_data/meetings/YYYY-MM-DD.yml`, using the meeting date as its filename:

```yaml
date: "2026-11-20"
institution: tartu
venue: delta
room: "314"
talks:
  - title: "Talk title"
    speaker: "Speaker name"
    affiliation: tartu
    time: "14:00"
    duration: "50 min"
    abstract: |
      Abstract or a short description. **Markdown** and $math$ are supported.
    slides: "assets/filename.pdf"
  - title: "Break"
    time: "14:50"
    duration: "10 min"
```

The build generates `/meetings/YYYY-MM-DD.html` automatically; no HTML file is
needed. Keep YAML files for past meetings. The front page and navigation update
automatically. Use matching ISO dates in filenames and the `date` field, since
filenames determine meeting order.

`date` and talk titles are required. Other fields are optional. For a meeting
whose programme is pending, use `talks: []`. Times should be quoted `HH:MM` strings
in Estonian local time. Talks sort by time regardless of their order in the file;
a talk without a time sorts first. Breaks can omit the speaker and abstract.
The optional `institution` and `venue` appear in the programme heading.
`institution` accepts a key from `_data/places.yml` or literal text.
The meeting's location and room appear in the heading; programme entries show
only their time.

Put slides in `assets/` and use paths such as `assets/filename.pdf`, relative to
the site root, or full external URLs. Links work on both the front page and
permanent meeting pages. Keep the existing October meeting as an example.

## Edit the site

`_layouts/meeting.html` contains the shared page template and introduction;
`index.html` selects that layout. Styling lives in `styles.css`. Institution and
building names are defined in `_data/places.yml`:

```yaml
institutions:
  taltech: "Tallinn University of Technology"
  tartu: "University of Tartu"
buildings:
  ict: "ICT Building"
  delta: "Delta Building"
```

`affiliation` and `venue` accept these keys or literal text. Unknown keys are
printed as written. Edit the shared names once to update every meeting.

## Use in another Jekyll project

Copy `index.html`, `styles.css`, and `assets/` into the desired source
folder. Copy `_plugins/meeting_pages.rb` into the host's `_plugins/`.
Merge `_layouts/meeting.html` into the host's `_layouts/`, and merge
`_data/meetings/` and `_data/places.yml` into its top-level `_data/`. These Jekyll
support directories must live at the host site root. Resolve any naming conflicts
with existing data or layouts before copying.

Asset and navigation links are folder-relative, so the site can also be served
under a base path. Set the host's `url` and `baseurl` for canonical and social
preview URLs; optional metadata links are omitted when `url` is unset.
