# KsRaidSkip
Addon for monitoring raid-skip quests (which allow to skip part of raid and jump to specific boss).
Infromation from this https://www.wowhead.com/guides/raid-quests-to-skip-bosses Wowhead guide.

# Visual
### quest_name  quest_status _(optional:boss name)_
quest_status:
- not even started - red X
- started (i.e. quest is in questlog) - yellow question mark
- completed - green checkmark
if quest item drops from one specific boss - show boss name

# Plans
- [x] list all quests from BRF to Nyalotha
- [ ] Create files localization files for all locales
- [ ] find out id for Dazar'Alor mythic Jaina skip
- [ ] add "Settings" dialog
- [ ] option to hide lower-difficulty quests if top-difficulty quest is done (e.g. if mythic quest is done, normal quest is irrelevant)
