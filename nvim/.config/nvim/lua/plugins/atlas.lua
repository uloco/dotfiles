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
		keymaps = {
			ui = {
				submit = "<A-CR>",
				next_page = "<leader>jp",
				previous_page = "<leader>kp",
				open_actions = "<leader>ca",
				toggle_star = "<leader>G*",
				notifications = { open = "<leader>GN" },
			},
			pulls = {
				open_diff = "<leader>df",
				checkout = "<leader>Go",
				review = {
					approve = "<leader>Ga",
					request_changes = "<leader>Gx",
					submit_review = "<leader>Gs",
					add_task = "<leader>Gt",
					comment_templates = "<leader>GT",
					explorer = {
						next_file = "<leader>jf",
						previous_file = "<leader>kf",
						next_unreviewed_file = "<leader>ju",
						previous_unreviewed_file = "<leader>ku",
					},
					diff = {
						toggle_layout = "<leader>dl",
						toggle_compact = "<leader>dc",
						next_hunk = "<leader>jh",
						previous_hunk = "<leader>kh",
						toggle_review_panel = "<leader>dr",
						toggle_detail_panel = "<leader>dd",
						toggle_comments = "<leader>dC",
						next_comment = "<leader>jC",
						previous_comment = "<leader>kC",
						next_note = "<leader>jn",
						previous_note = "<leader>kn",
						add_note = "<leader>Gn",
						toggle_resolved = "<leader>Gd",
					},
				},
			},
		},
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
