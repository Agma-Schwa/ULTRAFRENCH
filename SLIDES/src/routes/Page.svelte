<script lang="ts">
    import "$lib/style.scss"
    export let classes = '';
</script>


<div class="page {classes}">
    <slot />
</div>