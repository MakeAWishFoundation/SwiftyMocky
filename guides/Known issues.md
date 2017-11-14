# Known issues

**Please always check, if your problem is not related to feature being not supported** - for that we have **"Supported Features"** section.

-----

## 1. When triggering generation - error about modules in different swift versions appears

This seems to be a problem with dependency to Sourcery, which, for some case, event if included as dependency in Pods, does not use project swift version setting. Use swift version support branches, or download/build Sourcery binary manually

## 2. Matcher [FATAL] error for simple Equatable / Sequence types

This happens for generic mocks - seems that wrapping generic methods causes breaking default resolving of generic contraints, and you might end up seeing something like `[FATAL] No registered matcher comparator for Int` or other types, that should be rather obvious.

As for now - the only valid solution is to add comparators for these types. There are convenience methods on matcher, that allows simple adding of comparators for types conforming to Equatable or Sequence.

See **Generics** section for more informations.

## 3. Generated Mock breaks

When methods has labels or attributes names that are either escaped using  ` ` `, or  are matching Swift keywords like `for, while, guard ...`. For now - we advise not to use that. It will be resolved in the future.
