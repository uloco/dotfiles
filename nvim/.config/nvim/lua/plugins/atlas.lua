--- Detect the atlas provider from the current git remote.
--- Returns "gitlab" for gitlab.boxine.de, "github" otherwise.
local function detect_provider()
	local remote = vim.fn.system("git remote get-url origin 2>/dev/null"):gsub("%s+$", "")
	if remote:find("gitlab.boxine.de") then
		return "gitlab"
	end
	return "github"
end

return {
	"emrearmagan/atlas.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
		"esmuellert/codediff.nvim",
	},
	keys = {
		{
			"<leader>Gp",
			function()
				vim.cmd("Atlas pulls " .. detect_provider())
			end,
			desc = "Atlas pulls",
		},
		{
			"<leader>Gi",
			function()
				vim.cmd("Atlas issues " .. detect_provider())
			end,
			desc = "Atlas issues",
		},
		{
			"<leader>Gr",
			function()
				vim.cmd("Atlas review")
			end,
			desc = "Atlas review",
		},
		{
			"<leader>Gc",
			function()
				vim.cmd("Atlas create")
			end,
			desc = "Atlas create",
		},
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
			repo_config = {
				paths = {
					-- GitLab
					["tonies/react-native"] = "~/Source/_freelance/tonies/tonies-app",
					-- GitHub
					["uloco/*"] = "~/Source/*",
					["bluloco/*"] = "~/Source/*",
					["uloco/bluloco.nvim"] = "~/Source/neovim/bluloco.nvim",
					["zesavi/*"] = "~/Source/_freelance/clypp/*",
					["phyiosfit-digital/*"] = "~/Source/_freelance/physiofit/*",
				},
			},
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
