# this creates self-contained HTML files which include journal entries
# and whisper-generated subtitles for any of my video logs
#
# https://github.com/seanbreckenridge/markdown_stew

JOURNAL_TARGET := $(shell echo "${XDG_DOCUMENTS_DIR}/NotesRendered/journal.html")
JOURNAL_FILES := $(shell find ${XDG_DOCUMENTS_DIR}/Notes/journal -name "*.md" | sort -r)

VLOGS_TARGET := $(shell echo "${XDG_DOCUMENTS_DIR}/NotesRendered/vlogs.html")
VLOGS_FILES := $(shell find "${HOME}/Files/Vlogs/" -name '*.srt' | sort -r)

VLOG_TXT_FILES_DIR := $(shell echo "${XDG_CACHE_HOME}/vlog_txt_files")

all: $(JOURNAL_TARGET) $(VLOGS_TARGET)

$(JOURNAL_TARGET): $(JOURNAL_FILES)
	markdown_stew -dark-mode -title Journal $(JOURNAL_FILES) > $(JOURNAL_TARGET)

$(VLOGS_TARGET): $(VLOGS_FILES)
	mkdir -p $(VLOG_TXT_FILES_DIR)
	$(foreach file, $(VLOGS_FILES), srt-to-text $(file) > $(VLOG_TXT_FILES_DIR)/$(shell basename $(file) .srt).txt;)
	FILES=$$(find $(VLOG_TXT_FILES_DIR) -name "*.txt" | sort -r); \
		markdown_stew -dark-mode -title Vlogs $$FILES > $(VLOGS_TARGET)

clean:
	rm -f $(JOURNAL_TARGET) $(VLOGS_TARGET)
	rm -rf $(VLOG_TXT_FILES_DIR)

.PHONY: all clean
