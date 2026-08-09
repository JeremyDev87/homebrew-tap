# Homebrew Tap for Local Wiki Librarian

This tap distributes [Local Wiki Librarian](https://github.com/JeremyDev87/librarian), a fail-closed, authority-aware retrieval CLI for local Markdown knowledge bases.

## Install

```bash
brew install JeremyDev87/tap/local-wiki-librarian
```

This installs two commands:

```bash
wiki-librarian --help
wiki-librarian-refresh --help
```

## Verify

```bash
brew test local-wiki-librarian
brew linkage --test local-wiki-librarian
```

## Uninstall

```bash
brew uninstall local-wiki-librarian
```

The formula builds from the immutable `v0.1.0` source release and pins its Python runtime dependency by URL and SHA-256. It does not modify a user's Wiki during installation. The formula test operates only on Homebrew's temporary test directory.

## License

The tap metadata is provided under the MIT License. Local Wiki Librarian is licensed under Apache-2.0; its vendored Wikimap component retains its upstream MIT license and provenance.
