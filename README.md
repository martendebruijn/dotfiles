# dotfiles

My personal dotfiles

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Contributing](#contributing)
  - [Installation](#installation)
  - [Authors](#authors)
  - [License](#license)

## Contributing

Please do not contribute to this repo.

## Installation

1. Install 1Password
2. Turn on the 1Password SSH agent
3. Make `~/.ssh/config`
4. Configure your SSH client:

```sh
Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

5. Clone this repository:

```sh
git clone git@github.com:martendebruijn/dotfiles.git
```

For more information see [the 1Password SSH documentation](https://developer.1password.com/docs/ssh).

## Authors

- **Marten de Bruijn** - [martendebruijn](https://github.com/martendebruijn)

## License

MIT License, see [LICENSE](/LICENSE)
