defmodule Tako.Accounts.Resources.NicknameValidation do
  use Ash.Resource.Validation

  @profanity_config Expletive.configure(blacklist: Expletive.Blacklist.english())

  @impl true
  def init(opts) do
    {:ok, opts}
  end

  @impl true
  def validate(changeset, _opts) do
    nickname = Ash.Changeset.get_attribute(changeset, :nickname)

    if nickname do
      if Expletive.profane?(nickname, @profanity_config) do
        {:error,
         Ash.Changeset.add_error(changeset,
           message: "Nickname contains profanity",
           value: nickname
         )}
      else
        :ok
      end
    else
      :ok
    end
  end
end
