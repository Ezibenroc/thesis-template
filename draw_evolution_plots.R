library(ggplot2)
library(dplyr)
library(readr)
library(patchwork)

palette = c(
    "#1b9e77",
    "#d95f02",
    "#7570b3",
    "#e7298a",
    "#66a61e",
    "#e6ab02",
    "#a6761d",
    "#666666"
)

df = read.csv("build/thesis_data.csv") %>%
    mutate(timestamp=parse_datetime(as.character(timestamp), "%Y-%m-%d %H:%M:%S")) %>%
    mutate(file_size = file_size*1e-6)
df_lagged = df %>%
    mutate_at(vars(-("timestamp")),lag)
df_combined = bind_rows(old=df, new=df_lagged, .id="source") %>%
    arrange(timestamp, source)
steps = data.frame(timestamp=c("2020/11/01", "2021/03/28", "2021/06/02"),
                   event=c("Start writing", "Finish writing", "Defense")) %>%
    mutate(timestamp=parse_datetime(as.character(timestamp), "%Y/%m/%d"))


draw_plot = function(ycol, color) {
    max_val = df[[ycol]] %>% max(na.rm=T)
    return(ggplot(df) +
    aes_string(x="timestamp", y=ycol) +
    geom_step() +
    geom_ribbon(data=df_combined, aes_string(ymin=0, ymax=ycol), fill=color, alpha=0.5) +
    geom_point(shape='o') +
    geom_vline(data=steps, aes(xintercept=timestamp), linetype="dashed", color="black") +
    geom_label(data=steps, aes(x=timestamp, y=max_val/10, label=event), fill="gray", alpha=0.8, color="black", size=2) +
    xlab("Timestamp") +
    expand_limits(y=0) +
    expand_limits(x=steps %>% pull(timestamp) %>% min() - 3600*24*10) +
    expand_limits(x=steps %>% pull(timestamp) %>% max() + 3600*24*10) +
    theme_light() +
    theme(axis.title.x = element_blank())
    )
}

p1 = draw_plot("nb_pages", palette[1]) +
    ylab("Number of pages")
p2 = draw_plot("file_size", palette[2]) +
    ylab("File size (MB)")
p3 = draw_plot("compilation_duration", palette[3]) +
    ylab("Compilation duration (s)")

plot = p1 / p2 / p3 + plot_annotation(
    title = 'Evolution of the manuscript file'
)

ggsave("build/evolution_plot.png", plot=plot, width=4, height=8)
