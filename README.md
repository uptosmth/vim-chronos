# Chronos

This is a [chronos](https://github.com/uptosmth/chronos) vim integration.

Plugin records your activity and submits data to the locally running chronos daemon. See the [chronos](https://github.com/uptosmth/chronos) for more
information.

## Installation

- Using [Vundle](https://github.com/gmarik/vundle), add the following to your `vimrc`:

    ```vim
    Plugin 'uptosmth/vim-chronos'
    ```
  
## Configuration

There is no need to configure anything, but if you want to change the defaults here they are:

```vim
" Where to report the data (url)
let g:chronos_Url = "http://localhost:10203/heartbeats/editor"

" What is considered a minimum activity (seconds)
let g:chronos_SamplingInterval = 5

" How often to report the data (seconds)
let g:chronos_FlushInterval = 30
```

## Copyright & License

    Copyright (C) 2021 Viacheslav Tykhanovskyi

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
