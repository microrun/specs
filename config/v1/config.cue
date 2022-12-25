package v1

#Config: {
	providers: {
		[name=_]: #Provider

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
		[name=_]: #App
	}
}

#Provider: {
	// URI pointing to the provider implementation
	// Supported protocols: file:// and git over https://
	provider: string
	...
}

#App: {
	provider?: {
		use?: string
		...
	}
	build: #BuildImage | #BuildDockerfile
}

#BuildImage: {
	image: string
}

#BuildDockerfile: {
	dockerfile: "Dockerfile" | string
}