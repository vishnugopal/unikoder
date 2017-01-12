# Unikoder: for Unicode Steganography

## Intro
The basic premise is pretty simple. Unicode has [an unreasonable number](https://www.cs.tut.fi/~jkorpela/chars/spaces.html) of representations of a space character that look pretty indistinguishable from a normal one. So why not take a block of text, replace normal spaces by these special ones in a pattern that encodes information.

Most consumers of your encoded text wouldn't even know that it's hiding information. That's [steganography](https://en.wikipedia.org/wiki/Steganography) isn't it? :)

For example, there's a secret message encoded in this block of text. Can you find it?

  In general, web browsers and other programs should not be expected to render all space characters according to their definitions or descriptions. If the font used for text does not contain a glyph for a space character, a symbol of missing glyph may appear instead. This is a sad reality. And that is very much misundestood. What is true for earth is true for love as well. Oh, how the mighty fall!

## Download

Currently only available via Git.

    git clone git@github.com:vishnugopal/unikoder.git
    bundle    

This runs all the tests:

    bundle exec guard

## Usage

This is a demo via IRB:

    bundle exec irb
    require_relative("lib/unikoder")
    Unikoder.new.encode("Your secret message")
    => "lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa"

You can also provide your own block of text easily:

    Unikoder.new.encode("Your secret message", corpus: "In general, web browsers and other programs should not be expected to render all space characters according to their definitions or descriptions. If the font used for text does not contain a glyph for a space character, a symbol of missing glyph may appear instead. This is a sad reality. And that is very much misundestood. What is true for earth is true for love as well. Oh, how the mighty fall!")

Decoding is pretty simple as well. Find your text, and then:

    Unikoder.new.decode("In general, web browsers and other programs should not be expected to render all space characters according to their definitions or descriptions. If the font used for text does not contain a glyph for a space character, a symbol of missing glyph may appear instead. This is a sad reality. And that is very much misundestood. What is true for earth is true for love as well. Oh, how the mighty fall!")

## Copyright
Vishnu Gopal, 2016.

## License
MIT.
