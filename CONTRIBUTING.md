# Contributing

When contributing to this repository, please first discuss the change you wish to make via an [issue](https://github.com/MaastrichtU-IDS/get-started-with-docker/issues) if applicable.

If you are part of the [MaastrichtU-IDS organization on GitHub](https://github.com/MaastrichtU-IDS) you can directly create a branch in this repository. Otherwise you will need to first [fork this repository](https://github.com/MaastrichtU-IDS/get-started-with-docker/fork).

To contribute:

1. Clone the repository 📥

```bash
git clone https://github.com/MaastrichtU-IDS/get-started-with-docker.git
cd get-started-with-docker
```

2. Create a new branch from the `main` branch and add your changes to this branch 🕊️

```bash
git checkout -b my-branch
```

3. See how to run the program in development at https://github.com/MaastrichtU-IDS/get-started-with-docker
4. Re-generate the Table of Content:

Download the TOC generator

```bash
wget https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
chmod a+x gh-md-toc
```

Generate the Table of Content:

```bash
./gh-md-toc README.md
```

## Pull Request process

1. Ensure the workshop is working before sending a pull request 🧪
2. Update the `README.md` with details of changes, this includes new environment variables, exposed ports, useful file locations and container parameters 📝
3. [Send a pull request](https://github.com/MaastrichtU-IDS/get-started-with-docker/compare) to the `main` branch, answer the questions in the pull request message 📤
4. Project contributors will review your change as soon as they can ✔️

## Versioning process

The versioning scheme for new releases on GitHub used is [SemVer](http://semver.org/) (Semantic Versioning).
