# System Setup

Flashable zip that can be used to apply automatically some changes to the
system after a rom flash, this is the one that i use which is very simple,
older versions of this zip used to support pre-installation of system apps, in
this case Phonesky/Google Play Store that i was using with microG GMS (you can
see the commented lines in META-INF/com/google/android/update-binary)

Currently the zip:
- remove some system apps (i use alternatives to them like browser->firefox,
  messaging->QKSMS)
- set some properties in build.prop (240 dpi, enable nav bar)

This zip is mainly for reference, in case you want to use this as base for
something :)
