# Template for creating JSONLD Vocab on github pages (incomplete) 

This repository hosts the JSON-LD context and human-readable docs for the **.** vocabulary.

- Context: `https://.github.io/./context.jsonld`
- Docs:    `https://.github.io/./`


# Documentation

1. Create a GitHub repository

    Sign in (or sign up) at github.com.

    Click New to create a repo.

        Name it something like my-vocab (you’ll get a GitHub Pages URL at https://<you>.github.io/my-vocab/).

        Set it to Public.

        Check “Add a README” if you like.

2. Organize your files

In your local clone (or via the GitHub web editor), create this structure:

my-vocab/
├── docs/
│   ├── index.html
│   └── context.jsonld
└── README.md

    context.jsonld
    Your JSON-LD context file:

{
  "@context": {
    "ex": "https://<you>.github.io/my-vocab/context.jsonld#",
    "Person": "ex:Person",
    "name": "ex:name",
    "birthDate": {
      "@id": "ex:birthDate",
      "@type": "http://www.w3.org/2001/XMLSchema#date"
    }
  }
}

index.html
A simple HTML page explaining your vocab and showing examples. At minimum:

    <!doctype html>
    <html>
      <head>
        <meta charset="utf-8">
        <title>My Vocabulary</title>
        <!-- Users can fetch the context directly too: -->
        <link rel="alternate" type="application/ld+json"
              href="context.jsonld">
      </head>
      <body>
        <h1>My Vocabulary</h1>
        <p>This vocabulary defines:</p>
        <ul>
          <li><strong>Person</strong> (a human)</li>
          <li><strong>name</strong> (a string)</li>
          <li><strong>birthDate</strong> (an xsd:date)</li>
        </ul>

        <h2>JSON-LD Example</h2>
        <pre><code>{
    "@context": "https://<you>.github.io/my-vocab/context.jsonld",
    "@type": "Person",
    "name": "Alice",
    "birthDate": "1990-04-01"

}
</code></pre>
</body>
</html> ```
3. Enable GitHub Pages

    In your repo on GitHub.com, go to Settings → Pages.

    Under Source, select the main branch and the /docs folder, then Save.

    After a moment, you’ll see a published URL like

    https://<you>.github.io/my-vocab/

Everything in your docs/ folder is now publicly served there:

    Human-readable docs at
    https://<you>.github.io/my-vocab/

    Machine-readable context at
    https://<you>.github.io/my-vocab/context.jsonld

4. Referencing your vocabulary

On any page, people can now pull in your context:

<script type="application/ld+json">
{
  "@context": "https://<you>.github.io/my-vocab/context.jsonld",
  "@type": "Person",
  "name": "Charlie",
  "birthDate": "1985-12-05"
}
</script>

Or link in their <head>:

<link rel="jsonld context" href="https://<you>.github.io/my-vocab/context.jsonld">

5. Versioning & custom domain (optional)

    Versioned contexts: if you ever update your terms incompatibly, copy context.jsonld to v1.jsonld (or /v1/context.jsonld), then leave context.jsonld pointing at your latest.

    Custom domain: if you own vocab.example.com, you can add a CNAME file in docs/ and point DNS at GitHub Pages—so your URIs become https://vocab.example.com/context.jsonld.

That’s it! You now have a fully public, stable home for both your human-friendly docs and your JSON-LD context—all hosted for free on GitHub.
