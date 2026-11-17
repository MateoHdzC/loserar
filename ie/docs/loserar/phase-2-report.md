# Loserar Phase-2 Probe Report

- **Run date (UTC):** 2026-11-17T15:17:36Z
- **Host:** Darwin MacBook-Pro-de-Mateo.local 22.6.0 Darwin Kernel Version 22.6.0: Tue Jul 15 08:22:28 PDT 2025; root:xnu-8796.141.3.713.2~2/RELEASE_X86_64 x86_64
- **RAR:** `/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar`
- **RAR SHA-256:** `2512979417b2ba1c60f1a5783051931928099c3f407be8a12ef030c9cb54a8fb`
- **UNRAR:** `/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar`
- **UNRAR SHA-256:** `4a68e200b32ef9a6e2a4771a9d7cba7dcb1555d9b05556467b81aa8265a1edd8`
- **Per-case timeout:** 5s; implemented with POSIX sh background polling, `kill`, and `sleep`.
- **Temporary evidence:** self-owned fixtures only; the probe directory is removed on exit.

## Scope and safety

This report records one bounded macOS CLI run. No volume or recovery case was executed. No password discovery or bypass was attempted. No WinRAR Windows GUI is installed or tested; only the macOS RAR CLI pair above is available.

## Fixture hashes

| Kind | Path | Bytes | SHA-256 |
|---|---|---:|---|
| archive | `/tmp/loserar-phase2.Au79V3/archives/main.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/filter.rar` | 565 | `5421d1db5a55239304990c319f745b5d076462f012024a3cabf380b8c597b2a6` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/symlink-preserved.rar` | 101 | `3369e0b3f598108557de85736c55fb554a6459ecb343eed3ac1adefabc2aebaf` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/symlink-default.rar` | 96 | `99ebfe63b125900c1accd85337a03aa2d5b5d396de171d021a78068aa1cc5164` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m0.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m1.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m2.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m3.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m4.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/m5.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/dictionary-1m.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/solid.rar` | 618 | `dcb460974eba9f761ef8ce4ccdfd048a8a8f611f5c01694bbe33864107e1a94b` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/non-solid.rar` | 611 | `79498b4f6251a3699b4a2f90ea2a7f6398774b12d4d566c4dac04b549aac2bbb` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar` | 1099 | `69a15a097863611ac3a260fb7b9c88de36b7d2550c9d0fbdc2d2ea67d2eab811` |
| archive | `/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar` | 1454 | `2a6d98c7554dca5c7706aa9fbd1a6a7c53c5889b9e6ddf5c6b0b0db12b3df680` |
| fixture | `/tmp/loserar-phase2.Au79V3/archives/truncated.rar` | 64 | `944b91a3f900045399f0284241370c3bc41fbd568f57f9d3c669104f254a4613` |
| fixture | `/tmp/loserar-phase2.Au79V3/archives/malformed.rar` | 48 | `06138f5cd26d6cf06cc739eb8319d565f1eab8fe8f0cd0d8c99072696c53072b` |

## Case results

| Case | Exit | Timeout | Duration | Command |
|---|---:|---:|---:|---|
| `identity_rar_file` | `7` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' '/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar'` |
| `identity_rar_sha256` | `0` | `0` | 0s | `'shasum' '-a' '256' '/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar'` |
| `identity_rar_version` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' '-iver'` |
| `identity_rar_help` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' '-?'` |
| `identity_unrar_file` | `7` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' '/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar'` |
| `identity_unrar_sha256` | `0` | `0` | 0s | `'shasum' '-a' '256' '/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar'` |
| `identity_unrar_version` | `0` | `0` | 1s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' '-iver'` |
| `identity_unrar_help` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' '-?'` |
| `rar_a_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input'` |
| `rar_l_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'l' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `rar_t_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 't' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_l_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'l' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_lt_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lt' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_lta_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lta' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_lb_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lb' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_t_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `unrar_p_exact` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'p' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/nested/space dir/Unicode-é.txt'` |
| `unrar_p_dot_selector` | `10` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'p' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar' './input/nested/space dir/Unicode-é.txt'` |
| `unrar_p_dotdot_selector` | `10` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'p' '-p-' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/nested/space dir/../space dir/Unicode-é.txt'` |
| `unrar_e_flatten` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'e' '-p-' '-y' '-op/tmp/loserar-phase2.Au79V3/extract-e' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/*'` |
| `unrar_x_preserve` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'x' '-p-' '-y' '-op/tmp/loserar-phase2.Au79V3/extract-x' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/*'` |
| `unrar_x_nested_filter` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'x' '-p-' '-y' '-op/tmp/loserar-phase2.Au79V3/extract-filter' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/nested/*'` |
| `unrar_x_exclude_zero` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'x' '-p-' '-y' '-op/tmp/loserar-phase2.Au79V3/extract-exclude' '-xinput/zero-byte.bin' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/*'` |
| `unrar_e_collision_skip` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'e' '-p-' '-o-' '-op/tmp/loserar-phase2.Au79V3/collision-skip' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/a/duplicate.txt' 'input/b/duplicate.txt'` |
| `unrar_e_collision_overwrite` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'e' '-p-' '-o+' '-op/tmp/loserar-phase2.Au79V3/collision-overwrite' '/tmp/loserar-phase2.Au79V3/archives/main.rar' 'input/a/duplicate.txt' 'input/b/duplicate.txt'` |
| `rar_a_creation_filter` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-xinput/zero-byte.bin' '/tmp/loserar-phase2.Au79V3/archives/filter.rar' 'input'` |
| `unrar_l_creation_filter` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lb' '-p-' '/tmp/loserar-phase2.Au79V3/archives/filter.rar'` |
| `rar_a_symlink_preserve` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-ol' '/tmp/loserar-phase2.Au79V3/archives/symlink-preserved.rar' 'input/symlink-to-timestamp'` |
| `rar_a_symlink_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '/tmp/loserar-phase2.Au79V3/archives/symlink-default.rar' 'input/symlink-to-timestamp'` |
| `unrar_lt_symlink_preserve` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lta' '-p-' '/tmp/loserar-phase2.Au79V3/archives/symlink-preserved.rar'` |
| `unrar_lt_symlink_default` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'lta' '-p-' '/tmp/loserar-phase2.Au79V3/archives/symlink-default.rar'` |
| `rar_a_m0` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m0' '/tmp/loserar-phase2.Au79V3/archives/m0.rar' 'input'` |
| `rar_a_m1` | `0` | `0` | 1s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m1' '/tmp/loserar-phase2.Au79V3/archives/m1.rar' 'input'` |
| `rar_a_m2` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m2' '/tmp/loserar-phase2.Au79V3/archives/m2.rar' 'input'` |
| `rar_a_m3` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m3' '/tmp/loserar-phase2.Au79V3/archives/m3.rar' 'input'` |
| `rar_a_m4` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m4' '/tmp/loserar-phase2.Au79V3/archives/m4.rar' 'input'` |
| `rar_a_m5` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m5' '/tmp/loserar-phase2.Au79V3/archives/m5.rar' 'input'` |
| `rar_a_dictionary_64k` | `7` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m3' '-md64k' '/tmp/loserar-phase2.Au79V3/archives/dictionary-64k.rar' 'input'` |
| `rar_a_dictionary_1m` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-m3' '-md1m' '/tmp/loserar-phase2.Au79V3/archives/dictionary-1m.rar' 'input'` |
| `rar_a_solid` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-s' '/tmp/loserar-phase2.Au79V3/archives/solid.rar' 'input'` |
| `rar_a_non_solid` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-s-' '/tmp/loserar-phase2.Au79V3/archives/non-solid.rar' 'input'` |
| `rar_a_data_encryption` | `0` | `0` | 1s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-pLoserarDataPhase2!' '/tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar' 'input'` |
| `unrar_l_data_encryption_no_password` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'l' '-p-' '/tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar'` |
| `unrar_t_data_password` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-pLoserarDataPhase2!' '/tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar'` |
| `unrar_t_wrong_data_password` | `11` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-pWrongLoserarPassword' '/tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar'` |
| `rar_a_header_encryption` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-hpLoserarHeaderPhase2!' '/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar' 'input'` |
| `unrar_l_header_no_password` | `11` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'l' '-p-' '/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar'` |
| `unrar_l_header_password` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'l' '-pLoserarHeaderPhase2!' '/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar'` |
| `unrar_t_header_password` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-pLoserarHeaderPhase2!' '/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar'` |
| `unrar_t_wrong_header_password` | `11` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-pWrongLoserarPassword' '/tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar'` |
| `volumes_not_run` | `SKIPPED` | `0` | 0s | `rar a -v...; rar v ...; unrar t ...` |
| `recovery_not_run` | `SKIPPED` | `0` | 0s | `rar a -rr...; rar v ...; unrar t ...` |
| `fail_missing_unrar_t` | `10` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-p-' '/tmp/loserar-phase2.Au79V3/archives/does-not-exist.rar'` |
| `fail_missing_rar_l` | `10` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'l' '/tmp/loserar-phase2.Au79V3/archives/does-not-exist.rar'` |
| `fail_truncated_unrar_t` | `1` | `0` | 1s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-p-' '/tmp/loserar-phase2.Au79V3/archives/truncated.rar'` |
| `fail_truncated_rar_l` | `1` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'l' '/tmp/loserar-phase2.Au79V3/archives/truncated.rar'` |
| `fail_malformed_unrar_l` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 'l' '-p-' '/tmp/loserar-phase2.Au79V3/archives/malformed.rar'` |
| `fail_malformed_rar_l` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'l' '/tmp/loserar-phase2.Au79V3/archives/malformed.rar'` |
| `fail_unknown_unrar_switch` | `7` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar' 't' '-p-' '-LoserarUnknownSwitch' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `fail_unknown_rar_switch` | `0` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 't' '-LoserarUnknownSwitch' '/tmp/loserar-phase2.Au79V3/archives/main.rar'` |
| `fail_unsupported_rar_format` | `7` | `0` | 0s | `'/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar' 'a' '-y' '-ma4' '/tmp/loserar-phase2.Au79V3/archives/unsupported-ma4.rar' 'input'` |
| `rea_mcp_doctor` | `1` | `0` | 0s | `'/Users/mateo.hdz/.npm/_npx/af752b90495482d7/node_modules/.bin/rea' 'mcp' 'doctor' '--format' 'json'` |

## Exact stdout/stderr evidence

### `identity_rar_file` — exit `7`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Usage:     rar <command> -<switch 1> -<switch N> <archive> <files...>
               <@listfiles...> <path_to_extract/>

<Commands>
  a             Add files to archive
  c             Add archive comment
  ch            Change archive parameters
  cw            Write archive comment to file
  d             Delete files from archive
  e             Extract files without archived paths
  f             Freshen files in archive
  i[par]=<str>  Find string in archives
  k             Lock archive
  l[t[a],b]     List archive contents [technical[all], bare]
  m[f]          Move to archive [files only]
  p             Print file to stdout
  r             Repair archive
  rc            Reconstruct missing volumes
  rn            Rename archived files
  rr[N]         Add data recovery record
  rv[N]         Create recovery volumes
  s[name|-]     Convert archive to or from SFX
  t             Test archive files
  u             Update files in archive
  v[t[a],b]     Verbosely list archive contents [technical[all],bare]
  x             Extract files with full path

<Switches>
  -             Stop switches scanning
  @[+]          Disable [enable] file lists
  ad[1,2]       Alternate destination path
  ag[format]    Generate archive name using the current date
  ai            Ignore file attributes
  am[s,r]       Archive name and time [save, restore]
  ap<path>      Set path inside archive
  as            Synchronize archive contents
  c-            Disable comments show
  cfg-          Disable read configuration
  cl            Convert names to lower case
  cu            Convert names to upper case
  df            Delete files after archiving
  dh            Open shared files
  ds            Disable name sort for solid archive
  dw            Wipe files after archiving
  e[+]<attr>    Set file exclude and include attributes
  ed            Do not add empty directories
  ep            Exclude paths from names
  ep1           Exclude base directory from names
  ep3           Expand paths to full including the drive letter
  ep4<path>     Exclude the path prefix from names
  f             Freshen files
  hp[password]  Encrypt both file data and headers
  ht[b|c]       Select hash type [BLAKE2,CRC32] for file checksum
  id[c,d,n,p,q] Display or disable messages
  ierr          Send all messages to stderr
  ilog[name]    Log errors to file
  inul          Disable all messages
  isnd[-]       Control notification sounds
  iver          Display the version number
  k             Lock archive
  kb            Keep broken extracted files
  log[f][=name] Write names to log file
  m<0..5>       Set compression level (0-store...3-default...5-maximal)
  mc<par>       Set advanced compression parameters
  md[x]<n>[kmg] Dictionary size in KB, MB or GB
  me[par]       Set encryption parameters
  ms[ext;ext]   Specify file types to store
  mt<threads>   Set the number of threads
  n<file>       Additionally filter included files
  n@            Read additional filter masks from stdin
  n@<list>      Read additional filter masks from list file
  o[+|-]        Set the overwrite mode
  oh            Save hard links as the link instead of the file
  oi[0-4][:min] Save identical files as references
  ol[a,-]       Process symbolic links as the link [absolute paths, skip]
  om[-|1][=lst] Propagate Mark of the Web
  op<path>      Set the output path for extracted files
  or            Rename files automatically
  ow            Save or restore file owner and group
  p[password]   Set password
  qo[-|+]       Add quick open information [none|force]
  r             Recurse subdirectories
  r-            Disable recursion
  r0            Recurse subdirectories for wildcard names only
  rr[N]         Add data recovery record
  rv[N]         Create recovery volumes
  s[=<par>]     Create solid archive
  sc<chr>[obj]  Specify the character set
  sfx[name]     Create SFX archive
  si[name]      Read data from standard input (stdin)
  sl<size>[u]   Process files with size less than specified
  sm<size>[u]   Process files with size more than specified
  t             Test files after archiving
  ta[mcao]<d>   Process files modified after <d> YYYYMMDDHHMMSS date
  tb[mcao]<d>   Process files modified before <d> YYYYMMDDHHMMSS date
  tk[<date>]    Keep the original or set the specified archive time
  tl            Set archive time to latest file
  tn[mcao]<t>   Process files newer than <t> time
  to[mcao]<t>   Process files older than <t> time
  ts[m,c,a,p]   Save or restore time (modification, creation, access, preserve)
  u             Update files
  v             Create volumes with size autodetection or list all volumes
  v<size>[u]    Create volumes with size in [bBkKmMgGtT] units
  ver[n]        File version control
  vp            Pause before each volume
  w<path>       Assign work directory
  x<file>       Exclude specified file
  x@            Read file names to exclude from stdin
  x@<list>      Exclude files listed in specified list file
  y             Assume Yes on all queries
  z[file]       Read archive comment from file

```

**stderr**

```text
```

### `identity_rar_sha256` — exit `0`, timeout `0`

**stdout**

```text
2512979417b2ba1c60f1a5783051931928099c3f407be8a12ef030c9cb54a8fb  /Users/mateo.hdz/Documents/ie/tools/rar/rar/rar
```

**stderr**

```text
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LC_ALL = "C.UTF-8",
	LC_CTYPE = "C.UTF-8",
	LANG = "C.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```

### `identity_rar_version` — exit `0`, timeout `0`

**stdout**

```text
7.23
```

**stderr**

```text
```

### `identity_rar_help` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Usage:     rar <command> -<switch 1> -<switch N> <archive> <files...>
               <@listfiles...> <path_to_extract/>

<Commands>
  a             Add files to archive
  c             Add archive comment
  ch            Change archive parameters
  cw            Write archive comment to file
  d             Delete files from archive
  e             Extract files without archived paths
  f             Freshen files in archive
  i[par]=<str>  Find string in archives
  k             Lock archive
  l[t[a],b]     List archive contents [technical[all], bare]
  m[f]          Move to archive [files only]
  p             Print file to stdout
  r             Repair archive
  rc            Reconstruct missing volumes
  rn            Rename archived files
  rr[N]         Add data recovery record
  rv[N]         Create recovery volumes
  s[name|-]     Convert archive to or from SFX
  t             Test archive files
  u             Update files in archive
  v[t[a],b]     Verbosely list archive contents [technical[all],bare]
  x             Extract files with full path

<Switches>
  -             Stop switches scanning
  @[+]          Disable [enable] file lists
  ad[1,2]       Alternate destination path
  ag[format]    Generate archive name using the current date
  ai            Ignore file attributes
  am[s,r]       Archive name and time [save, restore]
  ap<path>      Set path inside archive
  as            Synchronize archive contents
  c-            Disable comments show
  cfg-          Disable read configuration
  cl            Convert names to lower case
  cu            Convert names to upper case
  df            Delete files after archiving
  dh            Open shared files
  ds            Disable name sort for solid archive
  dw            Wipe files after archiving
  e[+]<attr>    Set file exclude and include attributes
  ed            Do not add empty directories
  ep            Exclude paths from names
  ep1           Exclude base directory from names
  ep3           Expand paths to full including the drive letter
  ep4<path>     Exclude the path prefix from names
  f             Freshen files
  hp[password]  Encrypt both file data and headers
  ht[b|c]       Select hash type [BLAKE2,CRC32] for file checksum
  id[c,d,n,p,q] Display or disable messages
  ierr          Send all messages to stderr
  ilog[name]    Log errors to file
  inul          Disable all messages
  isnd[-]       Control notification sounds
  iver          Display the version number
  k             Lock archive
  kb            Keep broken extracted files
  log[f][=name] Write names to log file
  m<0..5>       Set compression level (0-store...3-default...5-maximal)
  mc<par>       Set advanced compression parameters
  md[x]<n>[kmg] Dictionary size in KB, MB or GB
  me[par]       Set encryption parameters
  ms[ext;ext]   Specify file types to store
  mt<threads>   Set the number of threads
  n<file>       Additionally filter included files
  n@            Read additional filter masks from stdin
  n@<list>      Read additional filter masks from list file
  o[+|-]        Set the overwrite mode
  oh            Save hard links as the link instead of the file
  oi[0-4][:min] Save identical files as references
  ol[a,-]       Process symbolic links as the link [absolute paths, skip]
  om[-|1][=lst] Propagate Mark of the Web
  op<path>      Set the output path for extracted files
  or            Rename files automatically
  ow            Save or restore file owner and group
  p[password]   Set password
  qo[-|+]       Add quick open information [none|force]
  r             Recurse subdirectories
  r-            Disable recursion
  r0            Recurse subdirectories for wildcard names only
  rr[N]         Add data recovery record
  rv[N]         Create recovery volumes
  s[=<par>]     Create solid archive
  sc<chr>[obj]  Specify the character set
  sfx[name]     Create SFX archive
  si[name]      Read data from standard input (stdin)
  sl<size>[u]   Process files with size less than specified
  sm<size>[u]   Process files with size more than specified
  t             Test files after archiving
  ta[mcao]<d>   Process files modified after <d> YYYYMMDDHHMMSS date
  tb[mcao]<d>   Process files modified before <d> YYYYMMDDHHMMSS date
  tk[<date>]    Keep the original or set the specified archive time
  tl            Set archive time to latest file
  tn[mcao]<t>   Process files newer than <t> time
  to[mcao]<t>   Process files older than <t> time
  ts[m,c,a,p]   Save or restore time (modification, creation, access, preserve)
  u             Update files
  v             Create volumes with size autodetection or list all volumes
  v<size>[u]    Create volumes with size in [bBkKmMgGtT] units
  ver[n]        File version control
  vp            Pause before each volume
  w<path>       Assign work directory
  x<file>       Exclude specified file
  x@            Read file names to exclude from stdin
  x@<list>      Exclude files listed in specified list file
  y             Assume Yes on all queries
  z[file]       Read archive comment from file
```

**stderr**

```text
```

### `identity_unrar_file` — exit `7`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Usage:     unrar <command> -<switch 1> -<switch N> <archive> <files...>
               <@listfiles...> <path_to_extract/>

<Commands>
  e             Extract files without archived paths
  l[t[a],b]     List archive contents [technical[all], bare]
  p             Print file to stdout
  t             Test archive files
  v[t[a],b]     Verbosely list archive contents [technical[all],bare]
  x             Extract files with full path

<Switches>
  -             Stop switches scanning
  @[+]          Disable [enable] file lists
  ad[1,2]       Alternate destination path
  ag[format]    Generate archive name using the current date
  ai            Ignore file attributes
  ap<path>      Set path inside archive
  c-            Disable comments show
  cfg-          Disable read configuration
  cl            Convert names to lower case
  cu            Convert names to upper case
  dh            Open shared files
  ep            Exclude paths from names
  ep3           Expand paths to full including the drive letter
  ep4<path>     Exclude the path prefix from names
  f             Freshen files
  id[c,d,n,p,q] Display or disable messages
  ierr          Send all messages to stderr
  inul          Disable all messages
  kb            Keep broken extracted files
  me[par]       Set encryption parameters
  n<file>       Additionally filter included files
  n@            Read additional filter masks from stdin
  n@<list>      Read additional filter masks from list file
  o[+|-]        Set the overwrite mode
  ol[a,-]       Process symbolic links as the link [absolute paths, skip]
  om[-|1][=lst] Propagate Mark of the Web
  op<path>      Set the output path for extracted files
  or            Rename files automatically
  ow            Save or restore file owner and group
  p[password]   Set password
  r             Recurse subdirectories
  sc<chr>[obj]  Specify the character set
  si[name]      Read data from standard input (stdin)
  sl<size>[u]   Process files with size less than specified
  ta[mcao]<d>   Process files modified after <d> YYYYMMDDHHMMSS date
  tb[mcao]<d>   Process files modified before <d> YYYYMMDDHHMMSS date
  tn[mcao]<t>   Process files newer than <t> time
  to[mcao]<t>   Process files older than <t> time
  ts[m,c,a,p]   Save or restore time (modification, creation, access, preserve)
  u             Update files
  v             List all volumes
  ver[n]        File version control
  vp            Pause before each volume
  x<file>       Exclude specified file
  x@            Read file names to exclude from stdin
  x@<list>      Exclude files listed in specified list file
  y             Assume Yes on all queries

```

**stderr**

```text
```

### `identity_unrar_sha256` — exit `0`, timeout `0`

**stdout**

```text
4a68e200b32ef9a6e2a4771a9d7cba7dcb1555d9b05556467b81aa8265a1edd8  /Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar
```

**stderr**

```text
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LC_ALL = "C.UTF-8",
	LC_CTYPE = "C.UTF-8",
	LANG = "C.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```

### `identity_unrar_version` — exit `0`, timeout `0`

**stdout**

```text
7.23
```

**stderr**

```text
```

### `identity_unrar_help` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Usage:     unrar <command> -<switch 1> -<switch N> <archive> <files...>
               <@listfiles...> <path_to_extract/>

<Commands>
  e             Extract files without archived paths
  l[t[a],b]     List archive contents [technical[all], bare]
  p             Print file to stdout
  t             Test archive files
  v[t[a],b]     Verbosely list archive contents [technical[all],bare]
  x             Extract files with full path

<Switches>
  -             Stop switches scanning
  @[+]          Disable [enable] file lists
  ad[1,2]       Alternate destination path
  ag[format]    Generate archive name using the current date
  ai            Ignore file attributes
  ap<path>      Set path inside archive
  c-            Disable comments show
  cfg-          Disable read configuration
  cl            Convert names to lower case
  cu            Convert names to upper case
  dh            Open shared files
  ep            Exclude paths from names
  ep3           Expand paths to full including the drive letter
  ep4<path>     Exclude the path prefix from names
  f             Freshen files
  id[c,d,n,p,q] Display or disable messages
  ierr          Send all messages to stderr
  inul          Disable all messages
  kb            Keep broken extracted files
  me[par]       Set encryption parameters
  n<file>       Additionally filter included files
  n@            Read additional filter masks from stdin
  n@<list>      Read additional filter masks from list file
  o[+|-]        Set the overwrite mode
  ol[a,-]       Process symbolic links as the link [absolute paths, skip]
  om[-|1][=lst] Propagate Mark of the Web
  op<path>      Set the output path for extracted files
  or            Rename files automatically
  ow            Save or restore file owner and group
  p[password]   Set password
  r             Recurse subdirectories
  sc<chr>[obj]  Specify the character set
  si[name]      Read data from standard input (stdin)
  sl<size>[u]   Process files with size less than specified
  ta[mcao]<d>   Process files modified after <d> YYYYMMDDHHMMSS date
  tb[mcao]<d>   Process files modified before <d> YYYYMMDDHHMMSS date
  tn[mcao]<t>   Process files newer than <t> time
  to[mcao]<t>   Process files older than <t> time
  ts[m,c,a,p]   Save or restore time (modification, creation, access, preserve)
  u             Update files
  v             List all volumes
  ver[n]        File version control
  vp            Pause before each volume
  x<file>       Exclude specified file
  x@            Read file names to exclude from stdin
  x@<list>      Exclude files listed in specified list file
  y             Assume Yes on all queries
```

**stderr**

```text
```

### `rar_a_default` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/main.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_l_default` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Archive: /tmp/loserar-phase2.Au79V3/archives/main.rar
Details: RAR 5

 Attributes       Size     Date    Time   Name
----------- ----------  ---------- -----  ----
 -rw-r-----         12  2020-01-02 03:04  input/symlink-to-timestamp
 -rw-r-----         12  2020-01-02 03:04  input/timestamp.txt
 -rw-r--r--         12  2026-11-17 10:17  input/a/duplicate.txt
 -rw-r--r--          0  2026-11-17 10:17  input/zero-byte.bin
 -rw-r--r--         10  2026-11-17 10:17  input/filter-me.txt
 -rw-r--r--         12  2026-11-17 10:17  input/nested/space dir/Unicode-�.txt
 -rw-r--r--         12  2026-11-17 10:17  input/b/duplicate.txt
 drwxr-xr-x          0  2026-11-17 10:17  input/nested/space dir
 drwxr-xr-x          0  2026-11-17 10:17  input/a
 drwxr-xr-x          0  2026-11-17 10:17  input/nested
 drwxr-xr-x          0  2026-11-17 10:17  input/b
 drwxr-xr-x          0  2026-11-17 10:17  input
----------- ----------  ---------- -----  ----
                    70                    12

```

**stderr**

```text
```

### `rar_t_default` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Testing archive /tmp/loserar-phase2.Au79V3/archives/main.rar

Testing     input/symlink-to-timestamp                                    15%  OK 
Testing     input/timestamp.txt                                           25%  OK 
Testing     input/a/duplicate.txt                                         35%  OK 
Testing     input/zero-byte.bin                                           43%  OK 
Testing     input/filter-me.txt                                           52%  OK 
Testing     input/nested/space dir/Unicode-�.txt                          65%  OK 
Testing     input/b/duplicate.txt                                         75%  OK 
Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
All OK
```

**stderr**

```text
```

### `unrar_l_default` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/main.rar
Details: RAR 5

 Attributes       Size     Date    Time   Name
----------- ----------  ---------- -----  ----
 -rw-r-----         12  2020-01-02 03:04  input/symlink-to-timestamp
 -rw-r-----         12  2020-01-02 03:04  input/timestamp.txt
 -rw-r--r--         12  2026-11-17 10:17  input/a/duplicate.txt
 -rw-r--r--          0  2026-11-17 10:17  input/zero-byte.bin
 -rw-r--r--         10  2026-11-17 10:17  input/filter-me.txt
 -rw-r--r--         12  2026-11-17 10:17  input/nested/space dir/Unicode-�.txt
 -rw-r--r--         12  2026-11-17 10:17  input/b/duplicate.txt
 drwxr-xr-x          0  2026-11-17 10:17  input/nested/space dir
 drwxr-xr-x          0  2026-11-17 10:17  input/a
 drwxr-xr-x          0  2026-11-17 10:17  input/nested
 drwxr-xr-x          0  2026-11-17 10:17  input/b
 drwxr-xr-x          0  2026-11-17 10:17  input
----------- ----------  ---------- -----  ----
                    70                    12

```

**stderr**

```text
```

### `unrar_lt_default` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/main.rar
Details: RAR 5

        Name: input/symlink-to-timestamp
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2020-01-02 03:04:05,000000000
  Attributes: -rw-r-----
       CRC32: 19787CD0
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/timestamp.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2020-01-02 03:04:05,000000000
  Attributes: -rw-r-----
       CRC32: 19787CD0
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/a/duplicate.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 14E83912
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/zero-byte.bin
        Type: File
        Size: 0
 Packed size: 0
       Ratio: 0%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 00000000
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/filter-me.txt
        Type: File
        Size: 10
 Packed size: 10
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 9399C685
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/nested/space dir/Unicode-�.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 22945282
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/b/duplicate.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 3FC56AD1
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/nested/space dir
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/a
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/nested
        Type: Directory
       mtime: 2026-11-17 10:17:31,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/b
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

```

**stderr**

```text
```

### `unrar_lta_default` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/main.rar
Details: RAR 5

        Name: input/symlink-to-timestamp
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2020-01-02 03:04:05,000000000
  Attributes: -rw-r-----
       CRC32: 19787CD0
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/timestamp.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2020-01-02 03:04:05,000000000
  Attributes: -rw-r-----
       CRC32: 19787CD0
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/a/duplicate.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 14E83912
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/zero-byte.bin
        Type: File
        Size: 0
 Packed size: 0
       Ratio: 0%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 00000000
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/filter-me.txt
        Type: File
        Size: 10
 Packed size: 10
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 9399C685
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/nested/space dir/Unicode-�.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 22945282
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/b/duplicate.txt
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: -rw-r--r--
       CRC32: 3FC56AD1
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

        Name: input/nested/space dir
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/a
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/nested
        Type: Directory
       mtime: 2026-11-17 10:17:31,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input/b
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

        Name: input
        Type: Directory
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: drwxr-xr-x
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0

     Service: EOF

```

**stderr**

```text
```

### `unrar_lb_default` — exit `0`, timeout `0`

**stdout**

```text
input/symlink-to-timestamp
input/timestamp.txt
input/a/duplicate.txt
input/zero-byte.bin
input/filter-me.txt
input/nested/space dir/Unicode-�.txt
input/b/duplicate.txt
input/nested/space dir
input/a
input/nested
input/b
input
```

**stderr**

```text
```

### `unrar_t_default` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Testing archive /tmp/loserar-phase2.Au79V3/archives/main.rar

Testing     input/symlink-to-timestamp                                    15%  OK 
Testing     input/timestamp.txt                                           25%  OK 
Testing     input/a/duplicate.txt                                         35%  OK 
Testing     input/zero-byte.bin                                           43%  OK 
Testing     input/filter-me.txt                                           52%  OK 
Testing     input/nested/space dir/Unicode-�.txt                          65%  OK 
Testing     input/b/duplicate.txt                                         75%  OK 
Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
All OK
```

**stderr**

```text
```

### `unrar_p_exact` — exit `0`, timeout `0`

**stdout**

```text
nested file
```

**stderr**

```text
```

### `unrar_p_dot_selector` — exit `10`, timeout `0`

**stdout**

```text
```

**stderr**

```text
```

### `unrar_p_dotdot_selector` — exit `10`, timeout `0`

**stdout**

```text
```

**stderr**

```text
```

### `unrar_e_flatten` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Extracting  /tmp/loserar-phase2.Au79V3/extract-e/symlink-to-timestamp      15%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/timestamp.txt            25%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/duplicate.txt            35%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/zero-byte.bin            43%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/filter-me.txt            52%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/Unicode-�.txt            65%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-e/duplicate.txt            75%  OK 
All OK
```

**stderr**

```text
```

### `unrar_x_preserve` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Creating    /tmp/loserar-phase2.Au79V3/extract-x/input                OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/symlink-to-timestamp      15%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/timestamp.txt      25%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-x/input/a              OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/a/duplicate.txt      35%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/zero-byte.bin      43%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/filter-me.txt      52%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-x/input/nested         OK
Creating    /tmp/loserar-phase2.Au79V3/extract-x/input/nested/space dir  OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/nested/space dir/Unicode-�.txt      65%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-x/input/b              OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-x/input/b/duplicate.txt      75%  OK 
All OK
```

**stderr**

```text
```

### `unrar_x_nested_filter` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Creating    /tmp/loserar-phase2.Au79V3/extract-filter/input           OK
Creating    /tmp/loserar-phase2.Au79V3/extract-filter/input/nested    OK
Creating    /tmp/loserar-phase2.Au79V3/extract-filter/input/nested/space dir  OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-filter/input/nested/space dir/Unicode-�.txt      65%  OK 
All OK
```

**stderr**

```text
```

### `unrar_x_exclude_zero` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Creating    /tmp/loserar-phase2.Au79V3/extract-exclude/input          OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/symlink-to-timestamp      15%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/timestamp.txt      25%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-exclude/input/a        OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/a/duplicate.txt      35%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/filter-me.txt      52%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-exclude/input/nested   OK
Creating    /tmp/loserar-phase2.Au79V3/extract-exclude/input/nested/space dir  OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/nested/space dir/Unicode-�.txt      65%  OK 
Creating    /tmp/loserar-phase2.Au79V3/extract-exclude/input/b        OK
Extracting  /tmp/loserar-phase2.Au79V3/extract-exclude/input/b/duplicate.txt      75%  OK 
All OK
```

**stderr**

```text
```

### `unrar_e_collision_skip` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Extracting  /tmp/loserar-phase2.Au79V3/collision-skip/duplicate.txt       35%  OK 
All OK
```

**stderr**

```text
```

### `unrar_e_collision_overwrite` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Extracting from /tmp/loserar-phase2.Au79V3/archives/main.rar

Extracting  /tmp/loserar-phase2.Au79V3/collision-overwrite/duplicate.txt      35%  OK 
Extracting  /tmp/loserar-phase2.Au79V3/collision-overwrite/duplicate.txt      75%  OK 
All OK
```

**stderr**

```text
```

### `rar_a_creation_filter` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/filter.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `unrar_l_creation_filter` — exit `0`, timeout `0`

**stdout**

```text
input/symlink-to-timestamp
input/timestamp.txt
input/a/duplicate.txt
input/filter-me.txt
input/nested/space dir/Unicode-�.txt
input/b/duplicate.txt
input/nested/space dir
input/a
input/nested
input/b
input
```

**stderr**

```text
```

### `rar_a_symlink_preserve` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/symlink-preserved.rar

Adding    input/symlink-to-timestamp                                       OK 
Done
```

**stderr**

```text
```

### `rar_a_symlink_default` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/symlink-default.rar

Adding    input/symlink-to-timestamp                                     100%  OK 
Done
```

**stderr**

```text
```

### `unrar_lt_symlink_preserve` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/symlink-preserved.rar
Details: RAR 5

        Name: input/symlink-to-timestamp
        Type: Unix symbolic link
      Target: timestamp.txt
        Size: 0
 Packed size: 0
       Ratio: 0%
       mtime: 2026-11-17 10:17:32,000000000
  Attributes: lrwxr-xr-x
       CRC32: 00000000
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

     Service: EOF

```

**stderr**

```text
```

### `unrar_lt_symlink_default` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/symlink-default.rar
Details: RAR 5

        Name: input/symlink-to-timestamp
        Type: File
        Size: 12
 Packed size: 12
       Ratio: 100%
       mtime: 2020-01-02 03:04:05,000000000
  Attributes: -rw-r-----
       CRC32: 19787CD0
     Host OS: Unix
 Compression: RAR 5.0(v50) -m0 -md=128k

     Service: EOF

```

**stderr**

```text
```

### `rar_a_m0` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m0.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_m1` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m1.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_m2` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m2.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_m3` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m3.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_m4` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m4.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_m5` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/m5.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_dictionary_64k` — exit `7`, timeout `0`

**stdout**

```text

ERROR: Unknown option: md64k
```

**stderr**

```text
```

### `rar_a_dictionary_1m` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/dictionary-1m.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_solid` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating solid archive /tmp/loserar-phase2.Au79V3/archives/solid.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/zero-byte.bin                                             17%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/b/duplicate.txt                                           68%  OK 
Adding    input/filter-me.txt                                             82%  OK 
Adding    input/timestamp.txt                                            100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/b                                                          OK 
Adding    input/nested                                                     OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_non_solid` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/non-solid.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `rar_a_data_encryption` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `unrar_l_data_encryption_no_password` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar
Details: RAR 5

 Attributes       Size     Date    Time   Name
----------- ----------  ---------- -----  ----
*-rw-r-----         12  2020-01-02 03:04  input/symlink-to-timestamp
*-rw-r-----         12  2020-01-02 03:04  input/timestamp.txt
*-rw-r--r--         12  2026-11-17 10:17  input/a/duplicate.txt
*-rw-r--r--          0  2026-11-17 10:17  input/zero-byte.bin
*-rw-r--r--         10  2026-11-17 10:17  input/filter-me.txt
*-rw-r--r--         12  2026-11-17 10:17  input/nested/space dir/Unicode-�.txt
*-rw-r--r--         12  2026-11-17 10:17  input/b/duplicate.txt
 drwxr-xr-x          0  2026-11-17 10:17  input/nested/space dir
 drwxr-xr-x          0  2026-11-17 10:17  input/a
 drwxr-xr-x          0  2026-11-17 10:17  input/nested
 drwxr-xr-x          0  2026-11-17 10:17  input/b
 drwxr-xr-x          0  2026-11-17 10:17  input
----------- ----------  ---------- -----  ----
                    70                    12

```

**stderr**

```text
```

### `unrar_t_data_password` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Testing archive /tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar

Testing     input/symlink-to-timestamp                                    14%  OK 
Testing     input/timestamp.txt                                           26%  OK 
Testing     input/a/duplicate.txt                                         38%  OK 
Testing     input/zero-byte.bin                                           49%  OK 
Testing     input/filter-me.txt                                           61%  OK 
Testing     input/nested/space dir/Unicode-�.txt                          74%  OK 
Testing     input/b/duplicate.txt                                         86%  OK 
Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
All OK
```

**stderr**

```text
```

### `unrar_t_wrong_data_password` — exit `11`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Testing archive /tmp/loserar-phase2.Au79V3/archives/data-encrypted.rar

Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
Total errors: 7
```

**stderr**

```text

Incorrect password for input/symlink-to-timestamp
Incorrect password for input/timestamp.txt
Incorrect password for input/a/duplicate.txt
Incorrect password for input/zero-byte.bin
Incorrect password for input/filter-me.txt
Incorrect password for input/nested/space dir/Unicode-�.txt
Incorrect password for input/b/duplicate.txt```

### `rar_a_header_encryption` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Evaluation copy. Please register.

Creating archive /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar

Adding    input/symlink-to-timestamp                                      17%  OK 
Adding    input/timestamp.txt                                             34%  OK 
Adding    input/a/duplicate.txt                                           51%  OK 
Adding    input/zero-byte.bin                                             51%  OK 
Adding    input/filter-me.txt                                             65%  OK 
Adding    input/nested/space dir/Unicode-�.txt                            82%  OK 
Adding    input/b/duplicate.txt                                          100%  OK 
Adding    input/nested/space dir                                           OK 
Adding    input/a                                                          OK 
Adding    input/nested                                                     OK 
Adding    input/b                                                          OK 
Adding    input                                                            OK 
Done
```

**stderr**

```text
```

### `unrar_l_header_no_password` — exit `11`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar
Details: RAR 5, encrypted headers
  0 files

```

**stderr**

```text

Incorrect password for /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar```

### `unrar_l_header_password` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Archive: /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar
Details: RAR 5, encrypted headers

 Attributes       Size     Date    Time   Name
----------- ----------  ---------- -----  ----
*-rw-r-----         12  2020-01-02 03:04  input/symlink-to-timestamp
*-rw-r-----         12  2020-01-02 03:04  input/timestamp.txt
*-rw-r--r--         12  2026-11-17 10:17  input/a/duplicate.txt
*-rw-r--r--          0  2026-11-17 10:17  input/zero-byte.bin
*-rw-r--r--         10  2026-11-17 10:17  input/filter-me.txt
*-rw-r--r--         12  2026-11-17 10:17  input/nested/space dir/Unicode-�.txt
*-rw-r--r--         12  2026-11-17 10:17  input/b/duplicate.txt
 drwxr-xr-x          0  2026-11-17 10:17  input/nested/space dir
 drwxr-xr-x          0  2026-11-17 10:17  input/a
 drwxr-xr-x          0  2026-11-17 10:17  input/nested
 drwxr-xr-x          0  2026-11-17 10:17  input/b
 drwxr-xr-x          0  2026-11-17 10:17  input
----------- ----------  ---------- -----  ----
                    70                    12

```

**stderr**

```text
```

### `unrar_t_header_password` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Testing archive /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar

Testing     input/symlink-to-timestamp                                    16%  OK 
Testing     input/timestamp.txt                                           26%  OK 
Testing     input/a/duplicate.txt                                         37%  OK 
Testing     input/zero-byte.bin                                           46%  OK 
Testing     input/filter-me.txt                                           56%  OK 
Testing     input/nested/space dir/Unicode-�.txt                          69%  OK 
Testing     input/b/duplicate.txt                                         80%  OK 
Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
All OK
```

**stderr**

```text
```

### `unrar_t_wrong_header_password` — exit `11`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Total errors: 1
```

**stderr**

```text

Incorrect password for /tmp/loserar-phase2.Au79V3/archives/header-encrypted.rar```

### `volumes_not_run` — exit `SKIPPED`, timeout `0`

**stdout**

```text
```

**stderr**

```text
Skipped by safety policy: volume creation/listing/testing was not proven noninteractive.
```

### `recovery_not_run` — exit `SKIPPED`, timeout `0`

**stdout**

```text
```

**stderr**

```text
Skipped by safety policy: recovery-record creation/listing/testing was not proven noninteractive.
```

### `fail_missing_unrar_t` — exit `10`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

No files to extract
```

**stderr**

```text

Cannot open /tmp/loserar-phase2.Au79V3/archives/does-not-exist.rar
No such file or directory```

### `fail_missing_rar_l` — exit `10`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

```

**stderr**

```text

Cannot open /tmp/loserar-phase2.Au79V3/archives/does-not-exist.rar
No such file or directory```

### `fail_truncated_unrar_t` — exit `1`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

Testing archive /tmp/loserar-phase2.Au79V3/archives/truncated.rar

No files to extract
```

**stderr**

```text

Unexpected end of archive
Unexpected end of archive```

### `fail_truncated_rar_l` — exit `1`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Archive: /tmp/loserar-phase2.Au79V3/archives/truncated.rar
Details: RAR 5
  0 files

```

**stderr**

```text

Unexpected end of archive
Unexpected end of archive```

### `fail_malformed_unrar_l` — exit `0`, timeout `0`

**stdout**

```text

UNRAR 7.23 freeware      Copyright (c) 1993-2026 Alexander Roshal

/tmp/loserar-phase2.Au79V3/archives/malformed.rar is not RAR archive
```

**stderr**

```text
```

### `fail_malformed_rar_l` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

/tmp/loserar-phase2.Au79V3/archives/malformed.rar is not RAR archive
```

**stderr**

```text
```

### `fail_unknown_unrar_switch` — exit `7`, timeout `0`

**stdout**

```text

ERROR: Unknown option: LoserarUnknownSwitch
```

**stderr**

```text
```

### `fail_unknown_rar_switch` — exit `0`, timeout `0`

**stdout**

```text

RAR 7.23   Copyright (c) 1993-2026 Alexander Roshal   27 Jun 2026
Trial version             Type 'rar -?' for help

Testing archive /tmp/loserar-phase2.Au79V3/archives/main.rar

Testing     input/symlink-to-timestamp                                    15%  OK 
Testing     input/timestamp.txt                                           25%  OK 
Testing     input/a/duplicate.txt                                         35%  OK 
Testing     input/zero-byte.bin                                           43%  OK 
Testing     input/filter-me.txt                                           52%  OK 
Testing     input/nested/space dir/Unicode-�.txt                          65%  OK 
Testing     input/b/duplicate.txt                                         75%  OK 
Testing     input/nested/space dir                                    OK
Testing     input/a                                                   OK
Testing     input/nested                                              OK
Testing     input/b                                                   OK
Testing     input                                                     OK
All OK
```

**stderr**

```text
```

### `fail_unsupported_rar_format` — exit `7`, timeout `0`

**stdout**

```text

ERROR: Unknown option: ma4
```

**stderr**

```text
```

### `rea_mcp_doctor` — exit `1`, timeout `0`

**stdout**

```text
```

**stderr**

```text
REA requires Node.js 22.x (>=22.23.4), 24.x (>=24.22.1), 26.12.1+; this process runs Node.js 24.18.0. Install a supported release, then retry.
```

## Observed

- The rows above are the complete observed result set for this run: command, exit code, timeout flag, duration, stdout, stderr, and artifact hashes.
- An exit code of `124` means the portable case bound fired; no such row is interpreted as successful behavior.
- A `SKIPPED` row is an intentional non-execution, not evidence of the underlying RAR feature.

## Inferred

- The tested `-p-` invocations provide an explicit no-password path for this run; this does not establish behavior for every password-related option.
- The observed P0 command, path, encryption, and failure rows are sufficient to begin a scoped phase-3 MVP for an independent Loserar CLI, provided implementation scope stays within those rows.

## Unknown

- Complete RAR/WinRAR compatibility, Windows GUI behavior, all archive formats, volumes, recovery records, advanced metadata, and untested flags remain unknown.
- The report does not claim source-level equivalence or complete protocol understanding.

## Coverage and skipped/blocked cases

- Covered: executable identity, creation, listing variants, testing, print-to-stdout, flatten/preserve extraction, filters, collisions, symlink fixture when available, compression levels, dictionary sizes, solid/non-solid creation, data/header encryption with explicit password/no-password/wrong-password paths, malformed/truncated/missing inputs, unknown switches, and unsupported format selection.
- Skipped: volume and recovery cases by safety policy; REA doctor when the `rea` CLI is absent; symlink cases only if `ln -s` was unavailable.
- Blocked: any case that times out is recorded in the table and evidence sections; the run continues without aborting.

## Validation

- `sh -n phase-2-probe.sh` is required before execution.
- This report was generated by the same probe run requested for phase 2.
