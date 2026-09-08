return {
	"emrearmagan/atlas.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
		"esmuellert/codediff.nvim",
	},
	opts = {
		providers = {
			github = {},
			gitlab = {
				base_url = "https://gitlab.boxine.de",
				token = vim.env.TONIES_GITLAB_TOKEN,
			},
		},
		pulls = {
			default_merge_method = "squash", -- "merge" or "squash"
			default_delete_branch = true,
			git_transport = "ssh",
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
			gitlab = {
				views = {
					{
						name = "My MRs",
						key = "1",
						layout = "plain",
						scope = "assigned_to_me",
					},
					{
						name = "Reviewing",
						key = "2",
						layout = "plain",
						scope = "reviews_for_me",
					},
				},
			},
		},
		issues = {
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
			gitlab = {
				views = {
					{
						name = "Assigned",
						key = "1",
						scope = "assigned_to_me",
						state = "opened",
					},
					{
						name = "Created",
						key = "2",
						scope = "created_by_me",
						state = "opened",
					},
				},
			},
		},
	},
}
