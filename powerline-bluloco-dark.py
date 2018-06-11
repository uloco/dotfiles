class DefaultColor(object):
    """
    This class should have the default colors for every segment.
    Please test every new segment with this theme first.
    """
    # RESET is not a real color code. It is used as in indicator
    # within the code that any foreground / background color should
    # be cleared
    RESET = -1

    USERNAME_FG = 231
    USERNAME_BG = 39
    USERNAME_ROOT_BG = 204

    HOSTNAME_FG = 252
    HOSTNAME_BG = 27

    HOME_SPECIAL_DISPLAY = False
    # HOME_BG = 99
    # HOME_FG = 254
    PATH_BG = 244
    PATH_FG = 252
    CWD_FG = 231
    SEPARATOR_FG = 252

    READONLY_BG = 209
    READONLY_FG = 255

    SSH_BG = 105
    SSH_FG = 254

    REPO_CLEAN_BG = 240
    REPO_CLEAN_FG = 254
    REPO_DIRTY_BG = 240
    REPO_DIRTY_FG = 204

    JOBS_FG = 39
    JOBS_BG = 242

    CMD_PASSED_BG = 238
    CMD_PASSED_FG = 254
    CMD_FAILED_BG = 197
    CMD_FAILED_FG = 254

    SVN_CHANGES_BG = 242
    SVN_CHANGES_FG = 204

    GIT_AHEAD_BG = 30
    GIT_AHEAD_FG = 254
    GIT_BEHIND_BG = 30
    GIT_BEHIND_FG = 254
    GIT_STAGED_BG = 35
    GIT_STAGED_FG = 254
    GIT_NOTSTAGED_BG = 209
    GIT_NOTSTAGED_FG = 231
    # GIT_NOTSTAGED_FG = 236
    GIT_UNTRACKED_BG = 204
    GIT_UNTRACKED_FG = 254
    GIT_CONFLICTED_BG = 99
    GIT_CONFLICTED_FG = 254

    GIT_STASH_BG = 222
    GIT_STASH_FG = 236

class Color(DefaultColor):
    """
    This subclass is required when the user chooses to use 'default' theme.
    Because the segments require a 'Color' class for every theme.
    """
    pass
