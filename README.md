# CONSUME.ash

CONSUME.ash handles your Kingdom of Loathing diet. This is a compatibility-focused downstream fork of [soolar/CONSUME.ash](https://github.com/soolar/CONSUME.ash).

**Downstream change:** command arguments are case-insensitive. Existing uppercase invocations keep working; there is no separate fork-specific command or filename.

## Installation

Install this fork through KoLmafia's graphical CLI:

```text
git checkout donCannoli-burns/consume.ash
```

Requires a recent KoLmafia build.

### Using this fork alongside upstream

The downstream fork has been used **with or without** `soolar/CONSUME.ash` installed. It keeps the same `CONSUME.ash` entrypoint and `CONSUME/` support-file paths so scripts that call the original filename can continue working. **Both Git checkouts manage overlapping files, however.** Installing or updating upstream may replace the active downstream version, and removing upstream may delete shared files. Keeping both repositories installed does not provide two independent copies of the script.

**If you decide to remove upstream after installing this fork:**

1. Remove **only the upstream** `soolar/CONSUME.ash` checkout through KoLmafia's Script Manager; leave `donCannoli-burns/consume.ash` installed.
2. In the gCLI, run `git sync` to restore any support files deleted by removing upstream.
3. Run `verify CONSUME` to confirm the script compiles and its imports resolve.
4. Run `CONSUME HELP` to check the entrypoint and register the lowercase `consume => CONSUME` alias.
5. Optionally run `consume sim value 6700` to preview a diet without executing it (change 6700 to your own adventure value).

The **`git sync` step is important**: removing upstream can leave `CONSUME.ash` present while deleting its four imported support files. In that situation, `verify CONSUME` may report missing `CONSUME/INFO.ash`, `CONSUME/CONSTANTS.ash`, `CONSUME/RECORDS.ash`, and `CONSUME/HELPERS.ash`, followed by many misleading undefined-type/function errors. Running `git sync` restored these files and resolved that failure in a confirmed KoLmafia installation.

If `git sync` does not repair the installation, check `git list` to confirm the downstream fork is still checked out before attempting to reinstall it. Avoid reinstalling upstream solely to recover its shared support files.

### Command and dependency compatibility

The installed entrypoint remains `scripts/CONSUME.ash`, and its `CONSUME/` imports remain unchanged. Existing scripts that invoke `CONSUME.ash` by filename continue to use that entrypoint. The following commands now all accept mixed-case arguments:

```text
CONSUME HELP
CONSUME help
CONSUME all
CONSUME nIgHtCaP sim
CONSUME organs 1 2 3
CONSUME value 5000 sim
```

### Automatic lowercase gCLI alias

Whenever `CONSUME.ash` starts, it runs the equivalent of this gCLI command:

```text
alias consume => CONSUME
```

KoLmafia saves aliases across sessions and characters. After the **first run** of the fork, these both work:

```text
consume all value 6700
CONSUME all value 6700
```

To register the alias safely on a fresh install, execute `CONSUME HELP` once. A newly installed script cannot register an alias until it has actually run; do not expect a first-ever `consume` invocation to work before registration. The script repeats registration on later runs, so this intentionally replaces any other gCLI alias named `consume`. To remove it, run `unalias consume` (the next run of this fork will reinstall it).

The physical script filename stays `CONSUME.ash` for case-sensitive Linux compatibility and dependent scripts. Lowercase gCLI invocations work via the alias, not via a renamed duplicate script.

**Dependency-manager limitation:** A script that simply runs `CONSUME.ash` can use this fork without edits. But a separate project's dependency declaration explicitly naming `github soolar/CONSUME.ash`, or a checkout-identity check for that upstream repository, is **not automatically redirected** to this fork. KoLmafia tracks Git checkouts separately, and automatic dependency installs/updates could reintroduce upstream and overwrite the installed file. Those declarations/checks need to be adjusted by the dependent project or handled explicitly during installation; this fork cannot intercept a package-manager checkout just by preserving the script filename.

For a safe smoke check, run `CONSUME HELP` and `CONSUME help` and confirm that both display the same help. Use `CONSUME SIM` / `CONSUME sim` to compare planning behavior before running `ALL`, which actually consumes items.

## Usage

First, work out how much meat an adventure is worth to you, and then enter
<pre>
set valueOfAdventure=that number
</pre>
After that, type `CONSUME HELP` in the gCLI to get a list of what you can do.
The output from `CONSUME SIM` can simply be copy/pasted in to the gCLI, if you so
desire, but repeat runs within the same session barely take any additional time,
so running `CONSUME ALL` after `CONSUME SIM` should be fine.

You can also set CONSUME.BASEMEAT to the base meat of whatever zone you meatfarm (if you meatfarm)
in order to have CONSUME consider the value of meat buffs in your diet. So far it only supports
sweet synthesis, but more is coming soon! As an example:
<pre>
set CONSUME.BASEMEAT=275
</pre>
is what you would want to do if you are farming barf mountain and have the songboom boombox.

## Supported

* General diet
* Nightcapping
* Saucemaven
* Pizza Lover
* Potion of the field gar
* Mojo filters
* Spice melange
* Ultra Mega Sour Ball
* Sweet Synthesis (optional)
* Mayoflex
* Frosty's Frosty Mug
* Ol' Scratch's Salad Fork
* Fudge Spork
* Special Seasoning
* Milk of Magnesium
* The Ode to Booze
* Mime army shotglass
* All chocolates other than LOV Extraterrestrial Chocolate (for now).
* Organ cleaning consumables (hobopolis/batfellow consumables)
* Considers cost of ingredients to make an item
* Essential tofu
* Ancestral Recall
* Alien plant pod
* Alien animal milk
* Hunger&trade; Sauce
* cuppa Voraci tea
* cuppa Sobrie tea
* sweet tooth
* lupine appetite hormones
* Universal Seasoning
* Meteorite Ade
* Jerks' Health&trade; Magazine
* synthetic dog hair pill (from Map to Safety Shelter Grimace Prime)
* distention pill (from Map to Safety Shelter Grimace Prime)
* Drip consumables (nugget/wine/caviar/plum(?)/pilsner)
* whet stone (from rock garden)
* Sweat Out Some Booze (from designer sweatpants)
* Aug. 16th: Roller Coaster Day! (from august scepter)
* extra time (from pile of burning leaves)
* mini kiwi aioli (from mini kiwi)
* clock (from Möbius ring)
* Stooper (when nightcapping)
* Maximizing for hp, hot res, and cold res if using any forks or mugs
* Restoring equipment to how it was before running the script if anything changed

# Calculating valueOfAdventure

valueOfAdventure can be a little tricky to get right. Contrary to popular belief,
it is NOT your gross profit divided by your # of adventures spent. It should
actually represent your worst case MPA, the MPA you achieve after any buffs that
don't last all day have worn off, because that's what you'r going to get from any
extra adventures that you add on to your diet.

First, look at your +meat% at the end of a day of farming. This is on top of the
base 100% meat you get from a monster without any +meat%, so add 100%. Multiply
this (the % number divided by 100) by the base meat of the area you farm. Then,
add any additional meat sources you have, such as screege's spectacles. This
should get you what you need to set valueOfAdventure to for optimal results.



For example:

Let's say I have 1000% +meat drops, and am farming barf mountain with songboom.
Barf mountain's base meat is 250, and songboom adds 25 to this, so you would
first multiply 275 by 11 to get 3025.

Now for the tricky part. We need to add
every additional source of meat from our shiny toys. First of all, the widely
popular mafia pointer finger ring. This does NOT count the songboom addition to
+meat, but is otherwise 200% meat dropped on a crit on average, so add 500 for 3525.

Next, Mr. Screege's spectacles. Between the meat items it drops and the pure
meat it drops, from what I hear it drops an average of roughly 180 MPA, besides
the +meat if provides (already factored in), so add 180 for 4325.

Next, lets consider the songboom's gathered meatclip drops. These give an average
of 520 meat according to the wiki, and drop every 11th combat. That gives us
roughly 47 MPA, so now we're up to 4372.

Moving along, the meat provided by the dark horse from the horsery. This grants
10-15 meat per combat, for an average of 13ish (I rounded down on the meat clip,
so I'm rounding up here). Now we're at 4385 MPA.

Next, let's look at the drops from the Robortender, from giving it a Feliz Navidad.
Frankly, I have absolutely no idea how much MPA this adds. Candy is worth a
decent bit though since the advent of Sweet Synthesis. Going by a brief grepping
of my log files, it looks like the robort drops candy roughly... a quarter of the
time? Let's go with that. Candy can be worth anywhere from 400 to 3000 meat, give
or take. Let's err on the side of caution and say that on average it will probably
be around 1000 meat or so, which means this is another 250 MPA. Up to 4635 MPA.

The robort also drops stuff from I Refuse! if you feed it a hobo drink. Most of
this stuff is truly worthless though, so I'm not even going to bother accounting
for it. Still worth it though, since you can get urinal cakes to throw at people.

Next up is the buddy bjorn. The best bjorn familiar (to my understanding) is the
warbear drone. This drops a warbear whosit every 4th or 5th combat, and those
sell for about 885 at the time of this writing, so that averages to 197 MPA.
Now we're at 4832.

Now, normal barrels from the shrine of the barrel god. Grepping my logs shows
something along the lines of a 1/10 drop rate. Most of the drops from a normal
barrel sell for 115 meat, so let's just call it 11.5 meat, and round that to 12.
Now we're at 4844.

Finally, hilarious drops from pantogram pants. There's roughly a 1/20 chance for
a drop, and a 1/23 chance for that to be a fake hand. Fake hands go for 60k meat
on the low end, so that's about 130 MPA. We're at 4974.

Now, we have to account for the fact that 1/30 adventures are replaced with a
non-combat. Multiply the results by 29/30, and add 1/30 times 1750, the average
yield of the noncombat. That puts us squarely at 4867 meat or so.

Lastly, we can multiply this by 1.05 if you use the mafia thumb ring, since that
gives an extra adventure 5% of the time. Final result is 5110 MPA.

After accounting for everything other than just the base meat, we've gone up by
a whopping 2085 MPA.

Obviously not everyone has every shiny listed here, so you'll have to work out
your MPA on your own based on this example. I also don't have every shiny that
exists, so I may have missed some things too. But hopefully this example makes
it completely clear how to find out your valueOfAdventure on your own!

## Special Thanks

I'm writing this script for my own sake, but my clannies at Reddit United have been very supportive!

Especially Rag Nymph (#2662313),
JorGen Van Doe (#3069483),
aurumbos (#2343846),
Lyft (#3045223),
and LordHaplo (#3165152),
all of whom have made my time all the more worthwhile with their kind donations!

## Don Report v1 (fork-only, read-only)

The separate `RELEASE/scripts/CONSUME/DON_REPORT.ash` can be invoked with `call CONSUME/DON_REPORT.ash organ_state --quiet` or `skills_current --print`. The main `CONSUME.ash` optimizer and its `cli_execute` diet runner remain **unchanged**; this standalone observer has no diet-planning imports or mutation functions. `--diff` reports **KNOWN_UNKNOWN** until a prior validated report receipt exists. No relay hook, persistent JSON writer or listener is active. Source policy and canonical addresses are defined in [Don KoLFix](https://github.com/donCannoli-burns/don_kolfix/blob/main/docs/don-report-v1.md).

