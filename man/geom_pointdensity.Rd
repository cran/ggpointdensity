\name{geom_pointdensity}
\alias{geom_pointdensity}
\alias{stat_pointdensity}
\alias{StatPointdensity}

\title{
A cross between a scatter plot and a 2D density plot
}
\description{
The pointdensity geom is used to create scatterplots where each point is colored by the number of neighboring points. This is useful to visualize the 2D-distribution of points in case of overplotting.
}
\usage{
geom_pointdensity(mapping = NULL, data = NULL,
  stat = "pointdensity", position = "identity",
  ..., na.rm = FALSE, show.legend = NA,
  inherit.aes = TRUE)
}

\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[=aes]{aes()}} or
\code{\link[=aes_]{aes_()}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}
\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[=ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[=fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{\dots}{Other arguments passed on to \code{\link[=layer]{layer()}}.
This includes \code{adjust}, a multiplicate bandwidth adjustment used to
adjust the distance threshold to consider two points as neighbors, i.e.
the radius around points in which neighbors are counted. For example,
\code{adjust = 0.5} means use half of the default. Other arguments may be
aesthetics, used to set an aesthetic to a fixed value, like \code{shape = 17}
or \code{size = 3}. They may also be parameters to the paired geom/stat.}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[=borders]{borders()}}.}
}

\references{
  https://GitHub.com/LKremer/ggpointdensity
}
\author{
  Lukas P.M. Kremer
}

\examples{
library(ggplot2)
library(dplyr)
library(ggpointdensity)

# generate some toy data
dat <- bind_rows(
  tibble(x = rnorm(7000, sd = 1),
         y = rnorm(7000, sd = 10),
         group = "foo"),
  tibble(x = rnorm(3000, mean = 1, sd = .5),
         y = rnorm(3000, mean = 7, sd = 5),
         group = "bar"))

# plot it with geom_pointdensity()
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity()

# adjust the smoothing bandwidth,
# i.e. the radius around the points
# in which neighbors are counted
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(adjust = .1)

ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity(adjust = 4)

# I recommend the viridis package
# for a more useful color scale
library(viridis)
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity() +
  scale_color_viridis()

# Of course you can combine the geom with standard
# ggplot2 features such as facets...
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity() +
  scale_color_viridis() +
  facet_wrap( ~ group)

# ... or point shape and size:
dat_subset <- sample_frac(dat, .1)  # smaller data set
ggplot(data = dat_subset, mapping = aes(x = x, y = y)) +
  geom_pointdensity(size = 3, shape = 17) +
  scale_color_viridis()

# Zooming into the axis works as well, keep in mind
# that xlim() and ylim() change the density since they
# remove data points.
# It may be better to use `coord_cartesian()` instead.
ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity() +
  scale_color_viridis() +
  xlim(c(-1, 3)) + ylim(c(-5, 15))

ggplot(data = dat, mapping = aes(x = x, y = y)) +
  geom_pointdensity() +
  scale_color_viridis() +
  coord_cartesian(xlim = c(-1, 3), ylim = c(-5, 15))
}
