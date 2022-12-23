provider:
	[name=_]:
		provider: string
		region: string

provider:
	aws:
		provider: "https://github.com/microrun/provider-aws"

apps:
	[name=_]:
		instanceType?: string
		build:
			image: string