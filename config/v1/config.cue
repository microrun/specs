providers: {
	[name=_]: {
		provider: string
	}

	[name="aws"]: {
		provider: "https://github.com/microrun/provider-aws.git"
	}

	[name="azure"]: {
		provider: "https://github.com/microrun/provider-azure.git"
	}

	[name="hcloud"]: {
		provider: "https://github.com/microrun/provider-hcloud.git"
	}
}

apps: {
	[name=_]: {
		build: {
			image: string
		}
	}
}
