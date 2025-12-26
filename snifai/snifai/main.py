import logging
import sys
from typing import Any, Optional

from snifai import __version__
from snifai.exceptions import OperationalException

# check min. python version (>= 3.10 required)
if sys.version_info < (3, 10):  # pragma: no cover
    sys.exit("Snifai requires Python version >= 3.10")

from snifai.commands import Arguments

logger = logging.getLogger("snifai")


def main(sysargv: Optional[list[str]] = None) -> None:
    return_code: Any = 1
    try:
        print("Snifai CLI")
        arguments = Arguments(sysargv)
        args = arguments.get_parsed_arg()

        # Call subcommand.
        if "func" in args:
            logger.info(f"snifai {__version__}")
            return_code = args["func"](args)
        else:
            # No subcommand was issued.
            raise OperationalException(
                "Usage of Snifai requires a subcommand to be specified.\n"
                "To see the full list of options available, please use "
                "`snifai --help` or `snifai <command> --help`."
            )
    finally:
        print("Exiting snifai")
        sys.exit(return_code)


if __name__ == "__main__":  # pragma: no cover
    main()
