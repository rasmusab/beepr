## Update

This update addresses the report of lingering aplay processes on Fedora.
Linux players are now waited for with a finite timeout. BEEPR_ENABLED=false
disables sound, and automated examples and listening tests are silent.

## Test environments

* macOS 27.0.1 (aarch64), R 4.5.2
* Fedora 44 (aarch64, Docker), R 4.6.1
* Windows Server 2022 (x64, win-builder), R-devel (2026-11-01 r90825 ucrt)

## R CMD check results

R CMD check --as-cran, including PDF and HTML manuals:

* macOS: 0 errors | 0 warnings | 1 note: unable to verify current time.
* Fedora: 0 errors | 0 warnings | 0 notes.
* Windows R-devel: 0 errors | 0 warnings | 0 notes.

The same source archive was also submitted to win-builder R-release; its
emailed result link is pending.

## Reverse dependency checks

Checked all 27 direct CRAN reverse dependencies (20 strong, 7 optional) against
CRAN beepr 2.0 and this update on Ubuntu 24.04 (aarch64), R 4.6.2.
There were no new check errors, warnings or notes. Tests and examples were
enabled; manuals and vignette rebuilding were skipped. DCPO reused its installed
CRAN binary to avoid recompiling its Stan models.
