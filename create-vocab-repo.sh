#!/usr/bin/env bash
set -e

REPO_NAME=.
BASE_URL="https://${GH_USER}.github.io/${REPO_NAME}"

#--- Scaffold locally
mkdir -p "$REPO_NAME/docs"
cd "$REPO_NAME"

cat > README.md <<EOF
# ${REPO_NAME}

This repository hosts the JSON-LD context and human-readable docs for the **${REPO_NAME}** vocabulary.

- Context: \`${BASE_URL}/context.jsonld\`
- Docs:    \`${BASE_URL}/\`
EOF

cat > docs/context.jsonld <<EOF
{
  "@context": {
    "ex": "${BASE_URL}/context.jsonld#",
    "Person": "ex:Person",
    "name": "ex:name",
    "birthDate": {
      "@id": "ex:birthDate",
      "@type": "http://www.w3.org/2001/XMLSchema#date"
    }
  }
}
EOF

cat > docs/index.html <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>${REPO_NAME} Vocabulary</title>
  <link rel="alternate" type="application/ld+json" href="context.jsonld">
</head>
<body>
  <h1>${REPO_NAME} Vocabulary</h1>
  <p>This vocabulary defines:</p>
  <ul>
    <li><strong>Person</strong> (a human)</li>
    <li><strong>name</strong> (a string)</li>
    <li><strong>birthDate</strong> (an xsd:date)</li>
  </ul>

  <h2>JSON-LD Example</h2>
  <pre><code>{
  "@context": "${BASE_URL}/context.jsonld",
  "@type": "Person",
  "name": "Alice",
  "birthDate": "1990-04-01"
}
  </code></pre>
</body>
</html>
EOF

#--- Init Git & push
git init
git add .
git commit -m "Initial scaffold: context.jsonld + docs/index.html"

gh repo create "${GH_USER}/${REPO_NAME}" \
  --public \
  --description "${DESCRIPTION}" \
  --source=. \
  --remote=origin \
  --push \
  --confirm

#--- Enable Pages
gh api \
  --method POST \
  -H "Accept: application/vnd.github.v3+json" \
  /repos/"${GH_USER}"/"${REPO_NAME}"/pages \
  -f source.branch=main \
  -f source.path=/docs

echo
echo "🎉 Done! GitHub Pages is now live at:"
echo "    ${BASE_URL}/"
