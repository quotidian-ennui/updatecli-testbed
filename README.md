# updatecli-testbed

The suggested name was `fictional-couscous`

> This is just me playing around with updatecli without dirtying up my git commit tree; it's hacky and intentionally so. It might be usable, it might not. Intentionally has a bunch of stuff that needs updating, because otherwise why use updatecli?

- https://github.com/minamijoyo/hcledit (now in 0.55.0+)
- https://github.com/minamijoyo/tfupdate (because we don't wanna use dependabot?)


# Tasks

Install [just](https://github.com/casey/just) (and [xc](https://github.com/joerdav/xc) if you want to use xc to run tasks defined in the README). Because sometimes it's nice to not have to think about it.

## diff

Runs updatecli diff passing in terraform/image-spec.yml as the values.

```
just diff
```

## apply

Runs updatecli apply passing in terraform/image-spec.yml as the values.

```
just apply
```
