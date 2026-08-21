return {
	"emrearmagan/atlas.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
		"esmuellert/codediff.nvim",
	},
	opts = {
		pulls = {
			providers = {
				github = {
					views = {
						{
							name = "My PRs",
							key = "1",
							layout = "plain",
							search = "author:@me sort:updated-desc",
						},
						{
							name = "Review Requested",
							key = "2",
							layout = "plain",
							search = "review-requested:@me sort:updated-desc",
						},
					},
				},
			},
		},
		issues = {
			providers = {
				github = {
					views = {
						{
							name = "Assigned",
							key = "1",
							layout = "plain",
							search = "assignee:@me is:open",
						},
						{
							name = "Created",
							key = "2",
							layout = "plain",
							search = "author:@me is:open",
						},
					},
				},
			},
		},
	},
}
