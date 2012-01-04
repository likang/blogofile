from blogofile.cache import bf

blog = bf.config.controllers.blog


def run():
    path = bf.util.path_join("", "about","index.html")
    bf.writer.materialize_template("about.mako", path, {})
