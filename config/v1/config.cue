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
	provider: string
}

#App: {
	build: #BuildImage | #BuildDockerfile
}

#BuildImage: {
	image: string
}

#BuildDockerfile: {
	dockerfile: "Dockerfile" | string
}