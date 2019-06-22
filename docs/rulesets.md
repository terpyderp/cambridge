Rulesets
========

A **ruleset** is a set of rules that apply to any game mode.

A ruleset consists of the following things:

 * A *rotation system*, which defines how pieces move and rotate.
 * A *lock delay reset system*, which defines how pieces lock when they can no longer move or rotate.

If you're used to Nullpomino, you may notice a few things missing from that definition. For example, piece previews, hold queues, and randomizers have been moved to being game-specific rules, rather than rules that are changeable with the ruleset you use. Soft and hard drop behaviour is also game-specific now, so that times can be more plausibly compared across rulesets.

There are six rulesets currently supported:

* Cambridge - a ruleset original to Cambridge, used for all custom modes. Supports 180-degree rotations!

* SRS - the rotation system used in the Tetris Guideline games. Supports 180-degree rotations!
* Ti-SRS - SRS but with no 180-degree rotations.

* ARS - the rotation system from the original Tetris the Grand Master.
* Ti-ARS - ARS with floorkicks! From TGM3: Terror Instinct.
* Ace-ARS - ARS with floorkicks and move reset! From TGM ACE.