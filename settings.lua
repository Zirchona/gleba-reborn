local spoil_time_values = {
	"1-min",
	"2-min",
	"3-min",
	"5-min",
	"10-min",
	"15-min",
	"30-min",
	"45-min",
	"1-hr",
	"2-hr",
	"never",
}

data:extend({
	{
        type = "bool-setting",
        name = "gleba-reborn-advanced-bacteria-recipes",
        setting_type = "startup",
        order = "a[recipe]-a",
        default_value = true
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-extra-biochamber-recipes",
        setting_type = "startup",
        order = "a[recipe]-b",
        default_value = true
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-egg-free-biochamber",
        setting_type = "startup",
        order = "a[recipe]-c",
        default_value = true
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-useful-wood-fish",
        setting_type = "startup",
        order = "a[recipe]-d",
        default_value = true
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-hungry-biolab",
        setting_type = "startup",
        order = "b[rebalance]-a",
        default_value = true
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-better-soil",
        setting_type = "startup",
        order = "b[rebalance]-b",
        default_value = false
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-more-seeds",
        setting_type = "startup",
        order = "b[rebalance]-c",
        default_value = false
    },
	{
        type = "string-setting",
        name = "gleba-reborn-less-enemies",
        setting_type = "startup",
        order = "b[rebalance]-d",
        default_value = "start",
        allowed_values = {
			"normal",
			"start",
			"always"
		},
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-reset-science-spoilage",
        setting_type = "startup",
        order = "b[rebalance]-d",
        default_value = false
    },
	{
        type = "string-setting",
        name = "gleba-reborn-science-spoil-time",
        setting_type = "startup",
        order = "c[spoil]-a",
        default_value = "1-hr",
        allowed_values = spoil_time_values,
    },
	{
        type = "string-setting",
        name = "gleba-reborn-nutrient-spoil-time",
        setting_type = "startup",
        order = "c[spoil]-b",
        default_value = "5-min",
        allowed_values = spoil_time_values,
    },
	{
        type = "string-setting",
        name = "gleba-reborn-bacteria-spoil-time",
        setting_type = "startup",
        order = "c[spoil]-c",
        default_value = "5-min",
        allowed_values = spoil_time_values,
    },
	{
        type = "bool-setting",
        name = "gleba-reborn-bacteria-spoilage",
        setting_type = "startup",
        order = "c[spoil]-d",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "gleba-reborn-compatability-mode",
        setting_type = "startup",
        order = "d[compatibility]-a",
        default_value = false
    },
})
