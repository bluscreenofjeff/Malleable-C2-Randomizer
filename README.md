# Malleable-C2-Randomizer
This script randomizes Cobalt Strike Malleable C2 profiles through the use of a metalanguage, hopefully reducing the chances of flagging signature-based detection controls. In short, the script parses the provided template, substitutes the variables for a random value from either a provided or built-in wordlist, tests the new template with *c2lint*, and (if there are no *c2lint* errors) outputs the new Malleable C2 file.

Sample Malleable C2 profiles that are compatible with this script can be found in the [Sample Templates](LINK-HERE) directory of this repo.

For more detailed information about the script's usage and how to implement the metalanguage in an existing Malleable C2 profile, check out my blog post [BLAHBLAHBLAH](LINK-HERE).

# Table of Contents
- [Script Syntax](#script-syntax)
    - [Basic Options](#basic-options)
    - [Custom Wordlists](#custom-wordlists)
- [Substitution Metalanguage](#substitution-metalanguage)
    - [List of Variables](#list-of-variables)
    - [Building Wordlists](#building-wordlists)
- [Example Template and Output](#example-template-and-output)
- [Further Resources](#further-resources)

# Script Syntax

```python
python malleable-c2-randomizer.py [-h] -profile PROFILE
                                  [-count COUNT]
                                  [-cobalt COBALT]
                                  [-output OUTPUT]
                                  [-notest]
                                  [-charset CHARSET]
                                  [-wordlist WORDLIST]
                                  [-useragent USERAGENT]
                                  [-spawnto SPAWNTO]
                                  [-pipename PIPENAME]
                                  [-pipename_stager PIPENAME_STAGER]
                                  [-dns_stager_subhost DNS_STAGER_SUBHOST]
```

## Basic Options
| Parameter | Description |
| ----- | ----- |
| -profile, -p | Path to the Malleable C2 template to randomize (REQUIRED) |
| -count, -c | The number of randomized profiles to create {Default = 1} |
| -cobalt, -d | The directory where Cobalt Strike is located (for c2lint) {Default = current directory} |
| -output, -o | Output base name {Default = template basename and random string} |
| -notest, -n | Skip testing with c2lint (Flag) |

## Custom Wordlists
If no wordlist is provided, a built-in list will be used by default. For more information about creating these lists, see [below](#building-wordlists) or the [sample wordlists](LINK-HERE) folder in this repo.

| Parameter | Description |
| ----- | ----- |
| -charset | File with a custom characterset to use with the %%customchar%% variable |
| -wordlist | File with a list of custom words to use with the %%word%% variable |
| -useragent | File with a list of useragents |
| -spawnto | File with a list of custom spawnto processes |
| -pipename | File with a list of custome pipenames |
| -pipename_stager | File with a list of custom pipename_stagers |
| -dns_stager_subhost | File with a list of custom dns_stager_subhosts |

Most of these wordlist variables are directly related to Malleable C2 options. For more information about what these profile options do, check out the [official documentation](https://www.cobaltstrike.com/help-malleable-c2).

# Substitution Metalanguage
The substitution metalanguage comprises specific variables, some of which allow optional repitition counts, wrapped in double percentage signs, like so:

```
%%variable:count%%
```

As another example, the following variable will result in 20 alphanumeric characters:

```
%%alphanumeric:20%%
```

## List of Variables

| Variable | Description | Supports Count? |
| ----- | ----- | ----- |
| alphanumeric | Outputs a random mixed-case ascii letter or digit | Yes |
| alphanumspecial | Outputs a random mixed-case ascii letter, digit, or punctuation | Yes |
| alphanumspecialurl | Outputs a random mixed-case ascii letter, digit, or one of the following characters: `-._~` | Yes |
| alphaupper | Outputs a random uppercase ascii letter | Yes |
| alphalower | Outputs a random lowercase ascii letter | Yes |
| alpha | Outputs a random ascii letter | Yes |
| number | Outputs a random digit | Yes |
| hex | Outputs a random hexadecimal digit | Yes |
| netbios | Outputs a random mixed-case ascii letter, digit, or one of the following characters: `!@#$%^&)(.-'_{}~` | Yes |
| custom | Maps to a random character in the provided *charset* file | Yes |
| word | Outputs a random word from the provided or built-in wordlist | Yes |
| useragent | Outputs a random useragent from the provided or built-in list | No |
| spawnto_x86 | Outputs a random x86 process path from the provided or built-in list | No |
| spawnto_x64 | Outputs a random x64 process path from the provided or built-in list | No |
| pipename | Outputs a random pipename from the provided or built-in list | No |
| pipename_stager | Outputs a random pipename_stager from the provided or built-in list | No |
| dns_stager_subhost | Outputs a random dns_stager_subhost from the provided or built-in list | No |

## Building Wordlists
Wordlist files are simply line-separated, tab-separated, or continuous strings (depending on the wordlist type) place in a text file.

The following wordlists should be line-separated with each entry on a new line:

* wordlist
* useragent
* pipename
* pipename_stager
* dns_stager_subhost

The spawnto wordlist is a bit more complicated. Malleable C2 requires an x86 and x64 option to modify all process spawning. Therefore, each line of the wordlist should contain both the x86 and x64 process paths separated by a tab, with the x86 process listed first. For example:

```
%windir%\\syswow64\\eventvwr.exe	%windir%\\sysnative\\eventvwr.exe
```

It's important to note that the `syswow64` and `sysnative` strings in the process paths should be **lowercase**.

The final wordlist type is the custom characterset. This file should include any characters for the script to randomly substitute. For example, a charset file of `AEIOUY` and a variable of `%%custom:5%%` will output five random characters from the charset string. When building this characterset, bear in mind that some characters are prohibited from appearing in a URI and may interfere with Beacon's communications.

For sample wordlists, see the [Sample Wordlists](LINK-HERE) directory in this repo.

# Example Template and Output
EXAMPLE GOES HERE

# Further Resources
malleable stuff goes here
